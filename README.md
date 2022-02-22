# monitoring.sh


#Bash script made for the project Born2beroot at the 42 school. 



#The goal of the project is to create a virtual machine in which we install a Linux operating system using Debian. 
#The monitoring.sh bash script helps to monitor informations and performances of such machine. 

#This script is being updated every 10 minutes using crontab rules: 

@reboot /root/bin/monitor/monitoring.sh | wall

*/10 * * * * /root/bin/monitor/monitoring.sh | wall

#/root/bin/monitor/monitoring.sh is Path to monitoring.sh in the virtual machine. 
