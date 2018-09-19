# /bin/bash

# Plain and simple check-n-start script to keep Bitcoin Daemon alive
#
# crontab line example:
# */1 * * * * 	/path/to/bitcoind.check.sh >/dev/null 2>&1
# removing the ">/dev/null 2>&1" will cause sending you mail with info


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
PROGRAM=bitcoind
PATHLOG=/home/statoshi/log
COMMAND="/usr/local/bin/bitcoind"


case "$(pgrep -c bitcoind)" in

0)  echo "Starting $PROGRAM:                  $(date)" >> $PATHLOG/$PROGRAM.log
    $COMMAND & #>/dev/null 2>&1
    ;;
1)  # all ok
    echo "$PROGRAM already running:           $(date)" >> $PATHLOG/$PROGRAM.log
    ;;
*)  echo "$PROGRAM is running multiple times: $(date)" >> $PATHLOG/$PROGRAM.log
    ### kill $(pgrep bitcoind |awk '{print $1}')
    ;;
esac
