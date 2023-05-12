
 Result01=$(cut -d ":" -f1 <<< "mtd11: 00010000 00010000 certificates")
 
 
 
 echo "Result is" "$Result01"
 





#conresult=$(echo "wifi123#" | sudo -S nmcli dev wifi connect "Maverick-130364") 2> rs.txt

if [[ "$checkconfile" == *"No network"*  ]];
then
    Broadcast="pass"
    echo "Broad Cast Pass Do not worry"
else
   echo "Broad Cast  not proper"
   
   Broadcast="fail"
fi



concsid=$(iwgetid)

echo "ssidname is"

echo "$concsid"

var=$(grep "Indio Failover" "$concsid")

echo "$var"

if [[ "$concsid" == *"Indio Failover Temp"* ]];
then 
   echo "could not find SSID -Could not ping as well"

   #Report_Log "Could not connect to AP SSID"
   
   Broadcast="fail"
   
else
  echo "No problem-01"
 fi
 
 
 
 
 if [[ "$concsid" =~ *"Indio Failover Temp"* ]];
then 
   echo "could not find SSID -Could not ping as well"

   #Report_Log "Could not connect to AP SSID"
   
   Broadcast="fail"
   
else
  echo "No problem-2"
 fi
 
 
 
 

 
