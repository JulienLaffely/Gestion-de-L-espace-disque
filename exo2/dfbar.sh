
#!bin/bash

barre(){
compt=0
echo -n "["
nb=$1
while [[ $nb -ge 5 ]] ; do
	echo -n "#" 
	nb=$nb-10
	compt=$compt+1
done
while [[ compt -lt 10 ]] ; do
	echo -n " "
	compt=$compt+1
done
echo -n "] "
}

espace(){
i=$((0))
OLDIFS="$IFS"
IFS=$'\n'
if [[ $4 == "false" ]];then
if [[ $1 == "true" ]]; then
tableau=$(df -h)
indice=34
fi
if [[ $1 == "true" && $2 == "true" ]]; then
tableau=$(df -h -l)
indice=34
fi
if [[ $1 == "false" && $2 == "true" ]]; then
tableau=$(df -l)
indice=45
fi
if [[ $3 == "true" ]]; then
tableau=$(df --total)
indice=48
fi
if [[ $1 == "true" && $2 == "true" && $3 == "true" ]]; then
tableau=$(df -h -l --total)
indice=34
fi
if [[ $1 == "true" && $2 == "false" && $3 == "true" ]]; then
tableau=$(df -h --total)
indice=34
fi
if [[ $1 == "false" && $2 == "true" && $3 == "true" ]]; then
tableau=$(df -l --total)
indice=46
fi
if [[ $1 == "false" && $2 == "false" && $3 == "false" ]]; then
tableau=$(df)
indice=45
fi
fi

if [[ $4 == "true" ]];then
if [[ $1 == "true" ]]; then
tableau=$(df -h | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=34
fi
if [[ $1 == "true" && $2 == "true" ]]; then
tableau=$(df -h -l | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=45
fi
if [[ $1 == "false" && $2 == "true" ]]; then
tableau=$(df -l | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=45
fi
if [[ $3 == "true" ]]; then
tableau=$(df --total | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=48
fi
if [[ $1 == "true" && $2 == "true" && $3 == "true" ]]; then
tableau=$(df -h -l --total | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=34
fi
if [[ $1 == "true" && $2 == "false" && $3 == "true" ]]; then
tableau=$(df -h --total | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=34
fi
if [[ $1 == "false" && $2 == "true" && $3 == "true" ]]; then
tableau=$(df -l --total | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=46
fi
if [[ $1 == "false" && $2 == "false" && $3 == "false" ]]; then
tableau=$(df | (read -r; printf "%s\n" "$REPLY"; sort -rk 5))
indice=45
fi
fi

for slot in $tableau
do
	if [[ $i -eq 0 ]]; then
		echo "           " $slot
	fi
	if [[ $i -gt 0 ]];then
		pourc=${slot:$indice:2}
		barre $pourc
		echo $slot
	fi
	i=$i+1
done
IFS="$OLD_IFS"
}

h="false"
l="false"
total="false"
sort="false"

while [[ $# -gt 0 ]] ; do
	arg=$1
	case $arg in
		-h)
			h="true"
			;;
		-l)
			l="true"
			;;
		--total)
			total="true"
			;;
		--sort)
			sort="true"
			;;
		--help)
			echo "Usage : ./dfbar.sh [-h] [-l] [--total] [--sort] [--help]"
			exit 1 
			;;
		*)
			echo "Unsupported option : $1"
			exit 1
	esac
	shift
done

espace $h $l $total $sort