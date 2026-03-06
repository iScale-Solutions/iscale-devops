#!/bin/bash

# =============================================================================
# EFS (Elastic File System) Backup Script by Jan David Afalla
# Syncs or archives an AWS EFS mount to an S3 bucket
# Logs are stored in the same directory as this script
# =============================================================================

# ── Directory & Log Setup ────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/efs_backup_$(date +%Y%m%d).log"

log() {
    local LEVEL="$1"
    shift
    local MESSAGE="$*"
    local TIMESTAMP
    TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[$TIMESTAMP] [$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}

log "INFO" "========================================"
log "INFO" "EFS Backup Script Started"
log "INFO" "========================================"

# ── Configurable Variables ───────────────────────────────────────────────────
# Override these or leave blank to be prompted interactively

EFS_ID="fs-04c0016044ca7e402"                   # EFS File System ID (e.g. fs-0abc1234)
EFS_MOUNT_POINT="/mnt/efs"          # Local mount path (e.g. /mnt/efs)
EFS_DNS=""                  # EFS DNS (auto-built if blank: $EFS_ID.efs.$AWS_REGION.amazonaws.com)
S3_BUCKET="iscale-dev-backups"                # Target S3 bucket name (without s3://)
S3_PREFIX="efs-backups"     # Folder/prefix inside the bucket
AWS_REGION="us-west-2"      # AWS region
BACKUP_MODE=""              # sync | archive
ARCHIVE_DIR="/tmp"          # Local temp dir for archive file (used in archive mode)
AUTO_MOUNT="false"          # Set to "true" to auto-mount EFS before backup

# ── Interactive Prompts ──────────────────────────────────────────────────────

prompt_if_empty() {
    local VAR_NAME="$1"
    local PROMPT_TEXT="$2"
    local CURRENT_VAL="${!VAR_NAME}"
    if [[ -z "$CURRENT_VAL" ]]; then
        read -rp "$PROMPT_TEXT: " INPUT
        eval "$VAR_NAME=\"$INPUT\""
    fi
}

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║        EFS → S3 Backup Utility           ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Backup mode selection
if [[ -z "$BACKUP_MODE" ]]; then
    echo "Select backup mode:"
    echo "  1) sync    — incremental sync (only changed files uploaded, fast)"
    echo "  2) archive — full tar.gz archive uploaded as a single file"
    read -rp "Enter choice [1 or 2]: " MODE_CHOICE
    case "$MODE_CHOICE" in
        1) BACKUP_MODE="sync" ;;
        2) BACKUP_MODE="archive" ;;
        *)
            log "ERROR" "Invalid mode choice: $MODE_CHOICE"
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
fi

log "INFO" "Backup mode selected: $BACKUP_MODE"

prompt_if_empty EFS_ID          "EFS File System ID (e.g. fs-0abc1234)"
prompt_if_empty AWS_REGION      "AWS Region [$AWS_REGION] (press Enter to keep default)"
prompt_if_empty EFS_MOUNT_POINT "EFS Local Mount Point (e.g. /mnt/efs)"
prompt_if_empty S3_BUCKET       "Target S3 Bucket Name (without s3://)"
prompt_if_empty S3_PREFIX       "S3 Prefix/Folder [$S3_PREFIX] (press Enter to keep default)"

# Build EFS DNS if not set
if [[ -z "$EFS_DNS" ]]; then
    EFS_DNS="${EFS_ID}.efs.${AWS_REGION}.amazonaws.com"
fi

echo ""
log "INFO" "Configuration:"
log "INFO" "  EFS ID        : $EFS_ID"
log "INFO" "  EFS DNS       : $EFS_DNS"
log "INFO" "  Mount Point   : $EFS_MOUNT_POINT"
log "INFO" "  Backup Mode   : $BACKUP_MODE"
log "INFO" "  S3 Bucket     : s3://$S3_BUCKET/$S3_PREFIX/"
log "INFO" "  AWS Region    : $AWS_REGION"

# ── Dependency Checks ────────────────────────────────────────────────────────

check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        log "ERROR" "Required tool not found: $1. Please install it and retry."
        exit 1
    fi
}

check_dependency aws

if [[ "$BACKUP_MODE" == "archive" ]]; then
    check_dependency tar
fi

log "INFO" "All required dependencies found."

# ── Mount EFS (optional) ─────────────────────────────────────────────────────

if [[ "$AUTO_MOUNT" == "true" ]]; then
    if ! mountpoint -q "$EFS_MOUNT_POINT"; then
        log "INFO" "Mounting EFS $EFS_ID at $EFS_MOUNT_POINT ..."
        mkdir -p "$EFS_MOUNT_POINT"
        mount -t nfs4 \
            -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
            "$EFS_DNS":/ "$EFS_MOUNT_POINT" 2>>"$LOG_FILE"

        if [[ $? -ne 0 ]]; then
            log "ERROR" "Failed to mount EFS. Check log for details."
            exit 1
        fi
        log "INFO" "EFS mounted successfully."
    else
        log "INFO" "EFS already mounted at $EFS_MOUNT_POINT."
    fi
else
    # Verify mount point exists and is accessible
    if [[ ! -d "$EFS_MOUNT_POINT" ]]; then
        log "ERROR" "Mount point does not exist: $EFS_MOUNT_POINT"
        echo "Mount point not found. Set AUTO_MOUNT=true or mount EFS manually first."
        exit 1
    fi

    if ! mountpoint -q "$EFS_MOUNT_POINT" 2>/dev/null; then
        log "WARN" "$EFS_MOUNT_POINT exists but may not be an active NFS mount. Proceeding anyway..."
    fi
fi

# ── Run Backup ───────────────────────────────────────────────────────────────

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [[ "$BACKUP_MODE" == "sync" ]]; then
    # ── Sync Mode ────────────────────────────────────────────────────────────
    S3_DEST="s3://$S3_BUCKET/$S3_PREFIX/$EFS_ID/"

    log "INFO" "Starting incremental sync: $EFS_MOUNT_POINT → $S3_DEST"

    aws s3 sync "$EFS_MOUNT_POINT" "$S3_DEST" \
        --region "$AWS_REGION" \
        --storage-class STANDARD_IA \
        --no-progress \
        2>>"$LOG_FILE"

    SYNC_EXIT=$?

    if [[ "$SYNC_EXIT" -ne 0 ]]; then
        log "ERROR" "S3 sync failed with exit code $SYNC_EXIT. Check log for details."
        exit 1
    fi

    log "INFO" "Sync completed successfully → $S3_DEST"

elif [[ "$BACKUP_MODE" == "archive" ]]; then
    # ── Archive Mode ─────────────────────────────────────────────────────────
    ARCHIVE_FILENAME="${EFS_ID}_${TIMESTAMP}.tar.gz"
    ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_FILENAME"
    S3_KEY="$S3_PREFIX/$ARCHIVE_FILENAME"

    log "INFO" "Creating archive: $ARCHIVE_PATH"

    tar -czf "$ARCHIVE_PATH" \
        -C "$(dirname "$EFS_MOUNT_POINT")" \
        "$(basename "$EFS_MOUNT_POINT")" \
        2>>"$LOG_FILE"

    TAR_EXIT=$?

    if [[ "$TAR_EXIT" -ne 0 ]]; then
        log "ERROR" "Archive creation failed with exit code $TAR_EXIT."
        rm -f "$ARCHIVE_PATH"
        exit 1
    fi

    ARCHIVE_SIZE=$(du -sh "$ARCHIVE_PATH" | cut -f1)
    log "INFO" "Archive created. Size: $ARCHIVE_SIZE"

    log "INFO" "Uploading archive to s3://$S3_BUCKET/$S3_KEY ..."

    aws s3 cp "$ARCHIVE_PATH" "s3://$S3_BUCKET/$S3_KEY" \
        --region "$AWS_REGION" \
        --storage-class STANDARD_IA \
        2>>"$LOG_FILE"

    S3_EXIT=$?

    if [[ "$S3_EXIT" -ne 0 ]]; then
        log "ERROR" "S3 upload failed with exit code $S3_EXIT."
        rm -f "$ARCHIVE_PATH"
        exit 1
    fi

    log "INFO" "Upload successful: s3://$S3_BUCKET/$S3_KEY"

    # Cleanup local archive
    rm -f "$ARCHIVE_PATH"
    log "INFO" "Temporary local archive removed."
fi

# ── Optional: Use AWS Backup via CLI ─────────────────────────────────────────
# Uncomment below to trigger a native AWS Backup job for EFS instead
#
# aws backup start-backup-job \
#     --backup-vault-name Default \
#     --resource-arn arn:aws:elasticfilesystem:$AWS_REGION:$(aws sts get-caller-identity --query Account --output text):file-system/$EFS_ID \
#     --iam-role-arn arn:aws:iam::ACCOUNT_ID:role/AWSBackupDefaultServiceRole \
#     --region "$AWS_REGION"

# ── Done ─────────────────────────────────────────────────────────────────────

log "INFO" "========================================"
log "INFO" "EFS Backup Completed Successfully!"
if [[ "$BACKUP_MODE" == "sync" ]]; then
    log "INFO" "  S3 Path  : s3://$S3_BUCKET/$S3_PREFIX/$EFS_ID/"
else
    log "INFO" "  S3 Path  : s3://$S3_BUCKET/$S3_KEY"
fi
log "INFO" "  Log File : $LOG_FILE"
log "INFO" "========================================"

echo ""
if [[ "$BACKUP_MODE" == "sync" ]]; then
    echo "✅ EFS synced to: s3://$S3_BUCKET/$S3_PREFIX/$EFS_ID/"
else
    echo "✅ EFS archived to: s3://$S3_BUCKET/$S3_KEY"
fi
echo "📄 Log saved to: $LOG_FILE"
echo ""