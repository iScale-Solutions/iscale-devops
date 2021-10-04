#!/bin/bash
echo "" > output.yaml
while read p; do
    sed "s,XXX,${p}," bank_template.yaml >> output.yaml
done <bank_list.txt