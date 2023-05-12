source ./CF.sh

source ./Log.sh


Run_CMD()

{

AP_IP="$1"

path="$2"

cm="$3"

expval="$4"

CMResult=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$1"errors.txt

sleep 2
		
ls
	
cd /"$path"
	
sleep 2
	
#ls -t
	
sleep 7
	
eval "$cm"
	
sleep 5
	
#ls -t

exit

EOF_run_commands
 
)



if [[ "$CMResult" == *"$expval"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "FM Upgradation could proceed"
 
 
else

  Report_Log "could not proceed with FM Up Gradation"
  
  printf "FM Upgradation could not proceed"
  
  exit
  
fi  


}

v="t"
#Run_CMD 172.31.255.186 "/tmp" "ls -$v"  "OpenWrt"




Copy_File_ToAP()

{

AP_IP="$1"

path="$2"

FName="$3"


sshpass -p "$APPWD" scp "$FName" "$APUID"@"$AP_IP":/"$path"/ 2> "$1"errors.txt


value=`cat "$1"errors.txt`  

#echo "Reason for of failure"

echo "$value"



if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not copy File"
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











