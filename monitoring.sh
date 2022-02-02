#!/bin/bash

#Scripts bash qui affiches les informations du terminal


#Architecture
uname -a | awk '{print "#Architecture: "$0}'
echo " "

#Nombre de processeurs physiques
lscpu | grep "CPU(s)" | head -1 | awk -F ":" '{print "#CPU physical : "$2}' | sed 's/ //g'

#Nombre de processeurs virtuels:
lscpu | grep "Core(s)" | awk -F ":" '{print "#vCPU : "$2}' | sed 's/ //g'
echo " "

#M√©moire vive disponible
free --mega | grep "Mem" | awk '{print "#Memory Usage: "$3"mg / "$2"mg ("$3/$2*100"%)"}'
echo " "
#M√©moire disponible 
df -BM | awk '{sum_all += $2} {sum_used += $3} END {print "#Disk Usage: " sum_used"mg / " sum_all "mg (" sum_used/sum_all*100 "%) " }'
df | awk '/LVM/ {print $6" "$5}'
echo " "

#Taux d'utilisation des processeurs/CPU load
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)/($2+$4+$5)*100} END {print "#CPU Load: "usage"%"}'
echo " "

#Date du dernier red√©marrage
last reboot | awk 'NR==1 {print "#Last boot: "$5" "$6" "$7" "$8}'
echo " "

#Si Lvm est actif ou non
LVM_ACTIVE=$(lsblk | grep lvm | wc -l)
if [ $LVM_ACTIVE = 0 ] ; then echo no;else echo "#LVM use: yes";fi
echo " "

#Le nombre de connexions utilis√es
netstat -tn | grep ESTABLISHED | wc -l | awk '{print "#Connexions TCP : "$0 " ESTABLISHED"}'

#Nombre d'utilisateur utilisant le serveur
who | awk '{print $1}' | uniq | wc -l | awk '{print "#User log: "$0}'

#Adresse IPV4 et Adresse MAC
ipv4_add=$(hostname -i)
mac_add=$(ip link show | awk '$1 == "link/ether" {print $2}')
echo "#Network: $ipv4_add  ($mac_add)" 

#Nombre de commande ex√cut√es avec sudo
wc -l /var/log/sudo/sudolog | awk '{print "#Sudo: "$1" cmd"}'

exit
