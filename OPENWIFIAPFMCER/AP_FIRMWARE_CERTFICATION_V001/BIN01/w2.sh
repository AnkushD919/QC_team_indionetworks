source ./CF.sh

id=130364

echo "$SSID""$id"

#conresult=$(echo "$machinepwd" | sudo -S nmcli dev wifi connect "$SSID""$id")

concssid=$(iwgetid)

<< com
echo "ssidname is"

echo "$concssid"

sleep 10

if [[ "$concssid" =~ *"$SSID""$id"* ]];
then 
echo "no problem"

fi

com



test1 ()

{

AP_IP="$1"

cm1="$2"

#cm2=$(sleep 10 ; cd /etc ; sleep 10 ; ls)

sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@"$AP_IP" << EOF_run_commands

eval "$cm1"

#echo "$cm1"

<<com
i="hi"


if [[ "$i" == *"$hi"* ]]; then
  printf "hi h r u"
fi

a=0
r=10

while [ $a -lt $r ]
do
   printf "no problem"
   a=`expr $a + 1`
done
com
EOF_run_commands

echo "I am done"
}



#test1 "192.168.100.4" "cd /tmp ; sleep 5; ls ; sleep 5; cd..; sleep 5; cd /etc ; sleep 5; ls "


#test1 "192.168.100.4" "sleep 10 ; cd /etc ; sleep 10 ; ls"


test1 "172.31.255.110" "sleep 5 ; cd /tmp ; sleep 5 ; ls"



#sed -i 's/192.168.178.9/ucjio.indionetworks.com/g' ucentral

#/etc/init.d/ucentral restart


