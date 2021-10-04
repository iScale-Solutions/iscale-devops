#!/bin/bash
echo "" > sqs.yaml
while read p; do
    sed "s,XXX,${p}," bank_template.yaml >> sqs.yaml
done <bank_list.txt
sed -e '/#XXX_INSERT_SQS_XXX/r./sqs.yaml' cics_template.yaml > cics.yaml
rm -f sqs.yaml