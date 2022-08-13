#!/bin/bash
mkdir -p packages

cd whimstay
zip ../packages/whimstay.zip *.py
cd ..

cd auto_alarm
zip ../packages/auto_alarm.zip *.py
cd ..
