#!/bin/bash
echo "" > sqs.yaml
while read p; do
    sed "s,XXX,${p}," bank_template.yaml >> sqs.yaml
    sed "s,XXX,${p}," notification_template.yaml >> notification.yaml
    sed "s,XXX,${p}," output_template.yaml >> output.yaml
done <bank_list_115.txt
sed "s,#NotificationConfiguration:,      NotificationConfiguration:," cics_template.yaml > cics_template2.yaml
sed "s,#QueueConfigurations:,        QueueConfigurations:," cics_template2.yaml > cics_template3.yaml

sed -e '/#XXX_INSERT_SQS_XXX/r./sqs.yaml' cics_template3.yaml > cics_1.yaml
sed -e '/#XXX_NOTIFICATION_CONFIG/r./notification.yaml' cics_1.yaml > cics_2.yaml
sed -e '/#XXX_INSERT_OUTPUT/r./output.yaml' cics_2.yaml > cics.yaml

rm -f cics_template2.yaml
rm -f cics_template3.yaml
rm -f cics_1.yaml
rm -f cics_2.yaml
rm -f output.yaml
rm -f sqs.yaml
rm -f notification.yaml