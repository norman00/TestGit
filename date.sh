#         Date: 12/06/2016
#
#  Description: The following script prints out the errors 500
#               in the last ten minutes found on the most recent
#               access log, which file was reviewed and temporarily
#               saves its output to temp.log
#               
#
# = = = = = = = = = = = = = = = = = = = = = = = = = 
# Variables
# - - - - - - - - - - - - - - - - - - - - - - - - -
LOGFILE=$(ls -Art | grep $(date +"%Y") | tail -n 1)
COUNTER=0
PDATE=$(date)
TLOG=./temp.log
MINS=10
#
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Functions
# - - - - - - - - - - - - - - - - - - - - - - - - -
#
function tag {
     echo "Error list in the last $MINS minutes" > $TLOG
     echo "- - - - - - - - - - - - - - - - - - - - - - -" >> $TLOG
     echo "Executed at "$(date)$'\n' >> $TLOG
}
function cycle {
     while [  $COUNTER -lt $MINS ]; do
         PDATE=$(date --date="$COUNTER min ago" +"%d"/"%b"/"%Y":"%H":"%M")
         awk '{print}' $LOGFILE | grep $PDATE | grep -w "500" >> $TLOG
         let COUNTER=COUNTER+1
     done
     echo $'\n' >> $TLOG
     echo "Taken from file "$LOGFILE >> $TLOG
     echo "- - - - - - - - - - - - - - - - - - - - - - -" >> $TLOG
     echo "temp.log has been created, it will be overwritten next time"$'\n' >> $TLOG
}
function publish {
     cat $TLOG
}
echo " "
tag
cycle
publish
echo ""
exit