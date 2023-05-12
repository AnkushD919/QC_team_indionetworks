source ./CF.sh


#./digicert-generate-ap-certs.sh INDIO "$Mac_add" ucjio.indionetworks.com


Connnect_Alpha () 
{
 
Alpha_IP="$Alphaserver"
       
Mac_add="$1"
       
printf "  I am in ALpha server     "


       
sleep 25
       
printf "mac=%s" "$Mac_add"

printf "  "

printf "Severname=%s" "$servername"

printf "  "
       
printf "AP_IP=%s" "$Alpha_IP"

printf "  "
  
sshpass -p "$Alphapwd" ssh -o StrictHostKeyChecking=no "$ALPHAUID"@"$Alpha_IP"<< EOF_run_commands 2> "$1"errors.txt

sleep 20
	
		
#ls
	
cd ugw/wlan-pki-cert-scripts

#ls 
#printf "Mac_add=%s" "$Mac_add"
	
sleep 20

./digicert-generate-ap-certs.sh INDIO "$Mac_add" "$servername"
	
sleep 20
	
cd ugw/wlan-pki-cert-scripts/generated
	
sleep 20
	
ls -t
	
	
exit

EOF_run_commands
 
value=`cat "$1"errors.txt` 


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "Sorry could not generated TAR"
  Report_Log "Could not Generate TAR File"
  rm "$1"errors.txt
  exit
else
 echo "No Problem Tar file generated";
  
  Report_Log "TAR File Generated"
  
  rm "$1"errors.txt
  
  
fi




  


 
}





Copy_Alpha()

{
mkdir TAR"$1"

sleep 5

Mac_add="$1"

cd TAR"$1"

sleep 15



sshpass -p "$Alphapwd" scp "$ALPHAUID"@"$Alphaserver":/home/alpha/ugw/wlan-pki-cert-scripts/generated/"$Mac_add" . 2> "$1"errors.txt

sleep 20


value=`cat "$1"errors.txt` 


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "Sorry could not Copy TAR"
  Report_Log "Could not Copy TAR File"
  rm "$1"errors.txt
  exit
else
 echo "No Problem Tar file copied";
  
  Report_Log "TAR File copied"
  
  rm "$1"errors.txt
  
  
fi

}
  
  
  
  
unzip_sqsh()

{

Mac_add_file="$1"

Mac_add="$2"



cd TAR"$1"

sleep 20


checksqfile=$(find . -name "$Mac_add_file")

printf "value is =%s" "$checksqfile"

exp='gz'

if [[ "$checksqfile" == *"$exp"* ]]; then

   echo "TAR File There."
  
else  
  echo "TAR file not found"  
  Report_Log "NO TAR FIle -Exiting"
  exit
fi







#mkdir "$Mac_add"



#tar xvzf "$Mac_add_file"-C /home/indio/Desktop/BIN001/AP_FIRMWARE_CERTFICATION/TAR/"$Mac_add"/


tar xvzf "$Mac_add_file"

sleep 20

rm "$Mac_add_file"

cd ..

sleep 20

mv TAR"$1" "$Mac_add"

sleep 20

cd "$Mac_add"

sleep 25

mv client.pem cert.pem && mv client_dec.key key.pem && mv client_deviceid.txt dev-id



cd ..

sleep 15

mksquashfs "$Mac_add"/ "$Mac_add".sqsh -comp xz

sleep 10

rm -r "$Mac_add"





 

}  
  
  
  
  
  
  
  
#checkerfile=$(find . -name memesult001.txt)

#printf "value is =%s" "$checkerfile"

#exp='me'

#if [[ "$checkerfile" == *"$exp"* ]]; 

#then
#  echo "The password is correct."
#else
#  echo "The password is incorrect, try again."
#fi

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
