#!/bin/bash

# =============================================================================
# RDS Database Backup Script by Jan David Afalla
# Dumps a MySQL or PostgreSQL RDS database and uploads it to S3
# Logs are stored in the same directory as this script
# =============================================================================

# ── Directory & Log Setup ────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/rds_backup_$(date +%Y%m%d).log"

log() {
    local LEVEL="$1"
    shift
    local MESSAGE="$*"
    local TIMESTAMP
    TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[$TIMESTAMP] [$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}

log "INFO" "========================================"
log "INFO" "RDS Backup Script Started"
log "INFO" "========================================"

# ── Configurable Variables ───────────────────────────────────────────────────
# Override these or leave blank to be prompted interactively

DB_ENGINE="postgres"          # mysql | postgres
DB_HOST=""            # RDS endpoint
DB_PORT="5432"            # default: 3306 (MySQL) or 5432 (PostgreSQL)
DB_NAME=""            # database name / identifier
DB_USER=""            # database username
DB_PASSWORD=""        # database password (will prompt if blank)
S3_BUCKET="iscale-dev-backups"          # target S3 bucket name (without s3://)
S3_PREFIX="chatbotaiprddb-rds-backups"  # folder/prefix inside the bucket
AWS_REGION="us-west-2"   # AWS region
BACKUP_DIR="/tmp"         # local temp dir for dump file

# ── Interactive Prompts ──────────────────────────────────────────────────────

prompt_if_empty() {
    local VAR_NAME="$1"
    local PROMPT_TEXT="$2"
    local IS_SECRET="${3:-false}"   # pass "true" to hide input
    local CURRENT_VAL="${!VAR_NAME}"

    if [[ -z "$CURRENT_VAL" ]]; then
        if [[ "$IS_SECRET" == "true" ]]; then
            read -rsp "$PROMPT_TEXT: " INPUT
            echo
        else
            read -rp "$PROMPT_TEXT: " INPUT
        fi
        eval "$VAR_NAME=\"$INPUT\""
    fi
}

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║        RDS → S3 Backup Utility           ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# DB Engine
if [[ -z "$DB_ENGINE" ]]; then
    echo "Select database engine:"
    echo "  1) MySQL / MariaDB"
    echo "  2) PostgreSQL"
    read -rp "Enter choice [1 or 2]: " ENGINE_CHOICE
    case "$ENGINE_CHOICE" in
        1) DB_ENGINE="mysql" ;;
        2) DB_ENGINE="postgres" ;;
        *)
            log "ERROR" "Invalid engine choice: $ENGINE_CHOICE"
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
fi

log "INFO" "Database engine selected: $DB_ENGINE"

# Set default port based on engine
if [[ -z "$DB_PORT" ]]; then
    [[ "$DB_ENGINE" == "mysql" ]] && DB_PORT="3306" || DB_PORT="5432"
fi

prompt_if_empty DB_HOST     "RDS Endpoint (host)"
prompt_if_empty DB_PORT     "DB Port [$DB_PORT] (press Enter to keep default)"
prompt_if_empty DB_NAME     "Database Name / Identifier"
prompt_if_empty DB_USER     "Database Username"
prompt_if_empty DB_PASSWORD "Database Password" "true"
prompt_if_empty S3_BUCKET   "Target S3 Bucket Name (without s3://)"
prompt_if_empty AWS_REGION  "AWS Region [$AWS_REGION] (press Enter to keep default)"

echo ""
log "INFO" "Configuration:"
log "INFO" "  Engine    : $DB_ENGINE"
log "INFO" "  Host      : $DB_HOST"
log "INFO" "  Port      : $DB_PORT"
log "INFO" "  Database  : $DB_NAME"
log "INFO" "  User      : $DB_USER"
log "INFO" "  S3 Bucket : s3://$S3_BUCKET/$S3_PREFIX/"
log "INFO" "  Region    : $AWS_REGION"

# ── Dependency Checks ────────────────────────────────────────────────────────

check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        log "ERROR" "Required tool not found: $1. Please install it and retry."
        exit 1
    fi
}

check_dependency aws

if [[ "$DB_ENGINE" == "mysql" ]]; then
    check_dependency mysqldump
else
    check_dependency pg_dump
fi

log "INFO" "All required dependencies found."

# ── Backup File Setup ────────────────────────────────────────────────────────

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILENAME="${DB_NAME}_${DB_ENGINE}_${TIMESTAMP}.sql.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILENAME"
S3_KEY="$S3_PREFIX/$BACKUP_FILENAME"

log "INFO" "Backup file: $BACKUP_PATH"
log "INFO" "S3 destination: s3://$S3_BUCKET/$S3_KEY"

# ── Dump Database ────────────────────────────────────────────────────────────

log "INFO" "Starting database dump..."

if [[ "$DB_ENGINE" == "mysql" ]]; then
    mysqldump \
        -h "$DB_HOST" \
        -P "$DB_PORT" \
        -u "$DB_USER" \
        -p"$DB_PASSWORD" \
        --single-transaction \
        --routines \
        --triggers \
        "$DB_NAME" 2>>"$LOG_FILE" | gzip > "$BACKUP_PATH"
    DUMP_EXIT="${PIPESTATUS[0]}"
else
    PGPASSWORD="$DB_PASSWORD" pg_dump \
        -h "$DB_HOST" \
        -p "$DB_PORT" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -F p 2>>"$LOG_FILE" | gzip > "$BACKUP_PATH"
    DUMP_EXIT="${PIPESTATUS[0]}"
fi

if [[ "$DUMP_EXIT" -ne 0 ]]; then
    log "ERROR" "Database dump failed with exit code $DUMP_EXIT. Check log for details."
    rm -f "$BACKUP_PATH"
    exit 1
fi

BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
log "INFO" "Dump completed successfully. File size: $BACKUP_SIZE"

# ── Upload to S3 ─────────────────────────────────────────────────────────────

log "INFO" "Uploading to S3..."

aws s3 cp "$BACKUP_PATH" "s3://$S3_BUCKET/$S3_KEY" \
    --region "$AWS_REGION" \
    --storage-class STANDARD_IA \
    2>>"$LOG_FILE"

S3_EXIT=$?

if [[ "$S3_EXIT" -ne 0 ]]; then
    log "ERROR" "S3 upload failed with exit code $S3_EXIT. Check log for details."
    rm -f "$BACKUP_PATH"
    exit 1
fi

log "INFO" "Upload successful: s3://$S3_BUCKET/$S3_KEY"

# ── Cleanup ──────────────────────────────────────────────────────────────────

rm -f "$BACKUP_PATH"
log "INFO" "Temporary local backup file removed."

# ── Done ─────────────────────────────────────────────────────────────────────

log "INFO" "========================================"
log "INFO" "Backup completed successfully!"
log "INFO" "  S3 Path : s3://$S3_BUCKET/$S3_KEY"
log "INFO" "  Log File: $LOG_FILE"
log "INFO" "========================================"

echo ""
echo "✅ Backup complete! Stored at: s3://$S3_BUCKET/$S3_KEY"
echo "📄 Log saved to: $LOG_FILE"
echo ""