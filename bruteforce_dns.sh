#!/bin/bash

# Constantes para facilitar a utilização das cores.
GREEN='\033[32;1m'
YELLOW='\033[33;1m'
RED_BLINK='\033[31;5;1m'
END='\033[m'

# Função chamada quando cancelar o programa com [Ctrl]+[c]
trap __Ctrl_c__ INT

__Ctrl_c__() {
    __Clear__
    printf "\n${RED_BLINK} [!] Ação abortada!${END}\n\n"
    exit 1
}

if [ "$1" == "" ] || [ "$2" == "" ]
then
	echo " "
	echo -e "${GREEN} [*] COMO USAR: ${END}"
	echo "     Especifique o site e a wordlist como argumento: "
	echo "     Exemplo: $0 site.com.br lista.txt"
else
	# Caso o usuario digitar www. ira remover antes de iniciar
	echo $1 >> temp_file
	site=$(cat temp_file | sed 's/www\.//')
	rm temp_file

	echo " "
	echo -e "${GREEN} [*] Realizando brute-force DNS em subdominios... ${END}"
	echo " "
	for dominio in $(cat $2);
	do
	host $dominio.$site | grep -v "NXDOMAIN" | sed 's/has address/\-\-\-\-\-\>/';
	done
	echo " "
	echo -e "${GREEN} [*] Finalizado! ${END}"
fi
