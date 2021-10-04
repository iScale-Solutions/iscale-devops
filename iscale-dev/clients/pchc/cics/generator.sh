#!/bin/bash
echo "" > sqs.yaml
while read p; do
    sed "s,XXX,${p}," bank_template.yaml >> sqs.yaml
    sed "s,XXX,${p}," notification_template.yaml >> notification.yaml
done <bank_list.txt
sed "s,#NotificationConfiguration:,      NotificationConfiguration:," cics_template.yaml > cics_template2.yaml
sed "s,#QueueConfigurations,        QueueConfigurations," cics_template2.yaml > cics_template.yaml
sed -e '/#XXX_INSERT_SQS_XXX/r./sqs.yaml' cics_template.yaml > cics_1.yaml
sed -e '/#XXX_NOTIFICATION_CONFIG/r./notification.yaml' cics_1.yaml > cics.yaml
rm -r cics_template2.yaml
rm -r cics_1.yaml
rm -f sqs.yaml
rm -f notification.yaml