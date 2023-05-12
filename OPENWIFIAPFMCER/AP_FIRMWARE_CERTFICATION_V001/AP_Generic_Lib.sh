source ./CF.sh

source ./Log.sh


Run_CMD()

{

AP_IP="$1"

path="$2"

cm="$3"

expval="$4"

Step_Name="$5"

echo "Expected Value is" "$expval"

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


<<com
if [[ "$CMResult" == *"$expval"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "$Step_Name""could proceed"
 
 
else

   Report_Log "$Step_Name""could not proceed"
  

  exit
  
fi  

com

value=`cat "$1"errors.txt`  

#echo "Reason for of failure"

echo "$value"



if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not coninue "
  
  Report_Log "$Step_Name -""could not continue"
  
  rm "$1"errors.txt
  exit
else

 echo "No Problem";
  
   Report_Log "$Step_Name -""could continue"
  
  rm "$1"errors.txt
  
  
fi
      
sleep 5 







}






Copy_File_ToAP()

{

AP_IP="$1"

path="$2"

FName="$3"

expval="$4"

Step_Name="$5"



sshpass -p "$APPWD" scp "$FName" "$APUID"@"$AP_IP":/"$path"/ 2> "$1"errors.txt


value=`cat "$1"errors.txt`  

#echo "Reason for of failure"

echo "$value"



if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not copy File"
  
  Report_Log "$Step_Name -""could not copy"
  
  rm "$1"errors.txt
  exit
else

 echo "No Problem File Copied";
  
   Report_Log "$Step_Name -""could copy"
  
  rm "$1"errors.txt
  
  
fi
      
sleep 5  






}



Verify_Expval_0()

{

AP_IP="$1"

path="$2"

cm="$3"

expval="$4"

Step_Name="$5"

echo "Expected Value is" "$expval"

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
  
  Report_Log "$Step_Name-""Pass"
  
  
else

   Report_Log "$Step_Name-""Fail" 
  
  exit
  
fi  


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not coninue "
  
  Report_Log "$Step_Name -""could not continue"
  
  rm "$1"errors.txt
  exit
else

 echo "No Problem";
  
   Report_Log "$Step_Name -""could continue"
  
  rm "$1"errors.txt
  
  
fi
      
sleep 5 



}





Verify_Expval_1()

{

AP_IP="$1"

path="$2"

cm="$3"

expval="$4"

Step_Name="$5"

echo "Expected Value is" "$expval"

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
  
  Res1="Pass"
  Report_Log "$Step_Name-""Pass"
  
  
else
    Res1="Fail"
   Report_Log "$Step_Name-""Fail" 
  
   
fi  


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "SOrry could not coninue "
  
  Report_Log "$Step_Name -""could not continue"
  
  rm "$1"errors.txt
  exit
else

 echo "No Problem";
  
   Report_Log "$Step_Name -""could continue"
  
  rm "$1"errors.txt
  
  
fi
      
sleep 5 



}




Verify_Expval_2()

{

cm="$1"

res=$(eval "${cm}")

SSID_NAME="$2"


if [[ "${res}" == *"$SSID_NAME"* ]]; then

echo "found donot worry"

Report_Log "$Step_Name -""pass"

Res2="Pass"

else

Res2="Fail"

echo "Not found"

Report_Log "$Step_Name -""pass"

fi


}

#SSID="Test-Report-Private"

#v3="$mc""  "$SSID""

#Verify_Expval_2  "nmcli dev wifi" "$v3" "Verify SSID NAME"











#Verify_Expval_0 172.17.0.1 "tmp" "ls" "dhcp.leases" ""


#Verify_Expval_0 172.17.0.1 "tmp" "ls" "bc33" ""



#Verify_Expval_0 172.17.0.1 "tmp" "cat sysinfo/model" "INDIO UM-305AX" ""



#Verify_Expval_0 172.17.0.1 "tmp" "cat sysinfo/model" "INDIO UM-307AX" ""



