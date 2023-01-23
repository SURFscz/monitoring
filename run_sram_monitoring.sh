#!/bin/sh
docker run --rm -d --name chrome -p 4444:4444 selenium/standalone-chrome >/dev/null 2>&1
while ! curl --output /dev/null --silent --head http://localhost:4444/wd/hub; do
#   echo -n "."
  sleep 1
done
# echo " Up!"
OUTPUT=$(./bin/python sram_monitoring_test.py config.yml)
RESULT=$?
docker stop chrome >/dev/null 2>&1
# echo "Down"
echo $OUTPUT > sram_monitoring.log
exit $RESULT
