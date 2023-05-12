source ./CF.sh

source ./Log.sh

Copy_sqsh_AP () 
{
 
AP_IP="$1"
       
CR_File="$2"
       
sleep 5
       
printf "CR_File=%s" "$CR_File"
       
sleep 5
    
  
sshpass -p "$APPWD" scp "$CR_File" "$APUID"@"$AP_IP":/tmp/ 2> "$1"errors.txt


value=`cat "$1"errors.txt`  

#echo "Reason for of failure"

echo "$value"



if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not copy SQSH"
  Report_Log "Could not Copy SQSH to AP- Exiting"
  rm "$1"errors.txt
  exit
else
 echo "No Problem SQSH Copied";
  
  Report_Log "SQSH Copied successfully to AP"
  
  rm "$1"errors.txt
  
  
fi
      
sleep 5     
  
}





Copy_FM_AP () 
{
       
cd FM
       
AP_IP="$1"
       
FM_File="$2"
       
sleep 5
       
printf "FM_File=%s" "$FM_File"
       
printf "AP_IP=%s" "$AP_IP"
       
sleep 5    
  
#sshpass -p 'openwifi' scp "$FM_File" root@"$AP_IP":/tmp/  
  
sshpass -p "$APPWD" scp "$FM_File" "$APUID"@"$AP_IP":/tmp/ 2> "$1"errors.txt

#sshpass -p 'openwifi' scp "$FM_File" root@"$AP_IP":/tmp/ 2> "$CMResult"

value=`cat "$1"errors.txt`  

#echo "Reason for of failure"

#echo "$value"



if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not copy FM "
  Report_Log "Could not Copy FM to AP - Exiting"
  rm "$1"errors.txt
  exit
else
  echo "No Problem FM Copied";
  
  Report_Log "FM Copied successfully to AP"
  
  rm "$1"errors.txt
  
  
fi




#rm errors.txt
     
sleep 5
      
cd ..

ls


  
}





Install_FM () 
{
 
AP_IP="$1"
       
FM_File="$2"
       
sleep 2
       
printf "FM_File=%s" "$FM_File"
       
printf "AP_IP=%s" "$AP_IP"
  
checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$1"errors.txt

sleep 2
		
ls
	
cd /tmp
	
sleep 2
	
ls -t
	
sleep 15
	
sysupgrade -F -n "$FM_File"
	
sleep 5
	
ls -t

exit

EOF_run_commands
 
)

if [[ "$checkconfile" == *"$FM_File"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "FM Upgradation could proceed"
 
 
else

  Report_Log "could not proceed with FM Up Gradation"
  
  printf "FM Upgradation could not proceed"
  
  exit
  
fi  
  
value=`cat "$1"errors.txt`   
  
if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host " ` -gt 0 ]] 
then
  echo "SOrry could not Continue FM Upgradation"
  Report_Log "Could not Continue FM Upgradation Exiting Due to exception "
  rm "$1"errors.txt
  exit
else
 echo "No Problem FM Upgradation could continue";
  
  Report_Log "FM Upgradation could continue -Verify"
  
  rm "$1"errors.txt
  
  
fi

  
  
  
}





Create_CR () 

{

AP_IP="$1"
       
SQ_File="$2"

MLoc="$3"
       
sleep 5    
       
printf "AP_IP=%s" "$AP_IP"
       
printf "SQ_File=%s" "$SQ_File"       
       
checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$1"errors.txt

sleep 5
		
ls
	
cd /tmp
	
sleep 5
	
ls -t
	
sleep 5
	
cat  /proc/mtd
	
sleep 10

echo "checking sqsh005"

(ls "$MLoc" && echo pass) || echo fail

ps | grep  D | tee pssult001.txt
	
mtd -e /dev/"$MLoc" write /tmp/"$SQ_File" /dev/"$MLoc"
		
sleep 60
	
#ls -t
	
reboot

sleep 5

exit

EOF_run_commands
      
)

if [[ "$checkconfile" == *"$MLoc"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "Certification could proceed"
 
 
else

  Report_Log "could not proceed with certification"
  
  printf "certification could  not proceed"
  
  exit
  
fi  

value=`cat "$1"errors.txt` 

if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host " ` -gt 0 ]] 
then
  echo "SOrry could not continue certification"
  Report_Log "SOrry could not continue certification"
  rm "$1"errors.txt
  exit
else
 echo "No Problem cerification could proceed";
  
  Report_Log "could  continue certification -Verify"
  
  rm "$1"errors.txt
  
  
fi




 

#sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@"$AP_IP" "cd /tmp; ls"

#sleep 5
#sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@"$AP_IP" "exit"   

#sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@"$AP_IP" "reboot"  

}





Get_memoryloc ()

{


AP_IP="$1"

Dname="$2"_MLOC



checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 5

#ps | grep  D | tee pssult002.txt
		
cat  /proc/mtd | tee /tmp/CResult001.txt

cd /tmp

ls
	
sleep 5
	

EOF_run_commands
)


if [[ "$checkconfile" == *"CResult001"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "Memory Location to write certificates found"
 
 
else

  Report_Log "Could not Get Memory Location to write certificates"
  
  printf "Memory to write Certificates not found"
  
  exit
  
fi  



mkdir "$Dname"

sleep 5


cd "$Dname"

sleep 5

sshpass -p "$APPWD" scp "$APUID"@"$AP_IP":/tmp/CResult001.txt . 2> "$1"errors.txt

#sshpass -p 'w1f1s0ft123#' scp alpha@192.168.3.6:/home/alpha/ugw/wlan-pki-cert-scripts/generated/"$Mac_add" .

sleep 5

value=`cat "$1"errors.txt` 


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host " ` -gt 0 ]] 
then
  echo "SOrry could not continue certification- Memrory Location not found"
  Report_Log "Sorry could not continue certification"
  rm "$1"errors.txt
  exit
else
 echo "No Problem cerification could proceed";
  
  Report_Log "could  continue certification -Verify"
  
  rm "$1"errors.txt
  
  
fi




Result=$(grep certificates  CResult001.txt)

printf "Result is=%s" "$Result"

#Mloc=$(echo ${Result:0:4})

sleep 3

Mloc=$(cut -d ":" -f1 <<< "$Result")
  
 
cd ..

rm -r "$Dname"

printf "mlocation is is=%s" "$Mloc"

printf "DOnontworry" 

#return "$Mloc"

#echo "$Mloc"



sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 2
		
cd /tmp

sleep 2

rm CResult001.txt
	
sleep 2
	

exit
EOF_run_commands


if [[ "$Mloc" == *"mtd"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "Certification could proceed-Memory Location found"
 
 
else

  Report_Log "could not proceed with certification- Memory Location not found"
  
  printf "certification could  not proceed"
  
  exit
  
fi 



}







Revoke_CR () 

{

AP_IP="$1"
       

MLoc="$2"
       
sleep 5    
       
printf "AP_IP=%s" "$AP_IP"
       
printf "Loc=%s" "$MLoc"      
       
sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@"$AP_IP"<< EOF_run_commands

sleep 5
		
ls
	
cd /tmp
	
sleep 5
	
ls -t
	
sleep 5
	
cat  /proc/mtd
	
sleep 10

mtd unlock /dev/"$MLoc"
	
	
sleep 20

mtd erase /dev/"$MLoc"
	
#ls -t
	
sleep 30

firstboot

sleep 5

#send "y\r"8
#sshpass -p 'y' ssh -o StrictHostKeyChecking=no root@"$AP_IP"

sleep 5

#reboot

exit 
EOF_run_commands
 

      
       

}











