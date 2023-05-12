#source ./Alpha.sh

#source ./AP_FM_CF.sh

#source ./AP_Verify.sh

#source ./AP_Basickcheck.sh

source ./Log.sh

source ./CF.sh

#source ./AP_Filecheck.sh

Get_AP_MAC ()

{


AP_IP="$1"

Dname="IPMAC""$1"



sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 5
		
ifconfig eth0 | tee /tmp/CResult001.txt


sleep 5
	
exit

EOF_run_commands

echo "I Found Mac second time"

echo $output


mkdir "$Dname"

sleep 5


cd "$Dname"

sleep 5

sshpass -p "$APPWD" scp "$APUID"@"$AP_IP":/tmp/CResult001.txt .



macAddress=$( cat CResult001.txt |grep -o -w -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}');
output=$(echo $macAddress | tr [:lower:] [:upper:]);
echo $output;

MAC=$output

sleep 3

cd ..

rm -r "$Dname"

printf "mac is is=%s" "$MAC"

printf "DOnontworry" 


sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 2
		
cd /tmp

sleep 2

rm CResult001.txt
	
sleep 2
	
exit

EOF_run_commands

if [[ "$MAC" != "" ]]; then

 printf "No problem"
 
 Report_Log "MAC  Found"

else
  printf "could not continue"
  
   Report_Log "MAC Not Found could not continue"
  
  exit
  
fi


}







Get_AP_IP ()

{

Dname="IP"

mkdir "$Dname"

cd "$Dname"

ip r | tee CResult001.txt


Result=$(grep "dev enp7s0 proto dhcp"  CResult001.txt)

printf "Result is=%s" "$Result"

IP=$(echo ${Result:12:12})

printf "Ip  is=%s" "$IP"

cd ..

sleep 10

rm -r  "$Dname"

if [[ "$IP" != "" ]]; then

 printf "No problem"
 
 Report_Log "AP IP Found"

else
  printf "could not continue"
  
   Report_Log "AP IP Not Found could not continue"
  
  exit
  
fi

}



Get_AP_IP_TD ()

{

searhip="$1"

Dname=TD

cd "$Dname"

sleep 5

printf "I am in directory TD"

Result=$(grep "$searhip"  TD)

printf "Result is=%s" "$Result"

n=${#Result}
echo "Length of the string is : $n "

IP=$(echo ${Result:4:$n})

printf "Ip  is=%s" "$IP"

cd ..

sleep 10


if [[ "$IP" != "" ]]; then

 printf "No problem"
 
 Report_Log "AP IP Found"

else
  printf "could not continue"
  
   Report_Log "AP IP Not Found could not continue"
  
  exit
  
fi

}



