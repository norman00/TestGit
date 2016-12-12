#!/bin/bash
#
#       Author: Eduardo Isai Rascon Garcia
#         Date: 12/06/2016
#
#  Description: The following script copies apache logs 
#               from 6pm to 9pm to a remote server
#
#               Variables explanation
#
#          LOG: Log name, to be copied to remote server
#           IP: Remote server IP address  
# LOGDIRECTORY: Local directory were apache logs reside
#  TRANSFERLOG: Local file that logs transfer history and status
#            U: Username to make secure copy
#        STORE: Directory on remote server were logs are stored
#
# = = = = = = = = = = = = = = = = = = = = = = = = =
LOG=$(date +"%Y_%m_%d_%H".log)
IP=192.168.56.104
LOGDIRECTORY=/home/erascong/Documents/jail/Epic/logs
TRANSFERLOG=/home/erascong/Documents/jail/Epic/transfer.log
U=operator
STORE=/archive/logs/
#
# - - - - - - - - - - - - - - - - - - - - - - - - -
#  Functions
# - - - - - - - - - - - - - - - - - - - - - - - - -
#
function tap {
     /usr/bin/touch $TRANSFERLOG  
} 
function check {
     date >> $TRANSFERLOG
}
function copy {
#
# secure copies the log file and stores its output to transferlog file
#
      scp $LOGDIRECTORY/$LOG $U@$IP:$STORE &>> $TRANSFERLOG
      if [ $? -eq 0 ]; then
          echo $LOG" Successfully saved"$'\n' >> $TRANSFERLOG
      else
          echo $LOG" Transfer error"$'\n' >> $TRANSFERLOG
      fi
}
#
tap
check
exit