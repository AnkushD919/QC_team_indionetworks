source ./CF.sh

source ./Log.sh

#source ./CF.sh

#source ./AP_Filecheck.sh


Verify_APDetials01()

{

Dname="$1"_Check

mc=$(echo "$1" | tr '[:upper:]' '[:lower:]')

mc1="$1"

echo "mc is " "$mc"


AP_IP="$2"



# Ping

checkconfile=$(sshpass -p "$APPWD" ssh -p 2233 "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

echo "I am pinging do not worry"
ping -c 5 -w 5  google.com

sleep 2
exit

EOF_run_commands
)

sleep 5

value=`cat "$AP_IP"errors.txt` 

rm "$AP_IP"errors.txt

Report_Log "Ping Results"


Report_Log ""$mc" $checkconfile"


if [[ "$checkconfile" == *"5 packets transmitted"* && "$checkconfile" == *"5 packets received"*  ]];
then
    ping="pass"
    echo "ping Pass Do not worry"
else
   echo "ping  not proper"
   
    ping="fail"
    
    Report_Log "Reason for Ping Failure"
    
    Report_Log "$value"
fi




# FM Verification


Verify_Expval_1 "$AP_IP" "tmp" "cat /etc/banner" "$FMVERSION" "Verify FM Version"

FM="$Res1"


# SSID


SSID="Test-Report-Private"

v3="$mc""  "$SSID""

Verify_Expval_2  "nmcli dev wifi" "$v3" "Verify SSID NAME"

Broadcast="$Res2"





#Report_SummaryLog "Brief Summary"

#Report_SummaryLog "MAC       FM Verison check  PING Results -  Braodcast Check  "

Report_SummaryLog "  "" "$mc"   "$FM-"    "$ping-"    "$Broadcast"   "

}

















