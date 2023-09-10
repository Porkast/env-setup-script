#!/bin/bash
echo "start running..."

# shellcheck disable=SC2046
# shellcheck disable=SC2006
kill -9 `cat pidfile.txt`

rm pidfile.txt

nohup ./bin/v1.0.0/linux_amd64/orange-firework & echo $! > pidfile.txt

echo "end"

exit