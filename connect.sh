#!/bin/bash

mkdir -p $HOME/.connect/
INVENTORY="$HOME/.connect/inventory.csv"
ENVIRONMENT='.'
HOSTS='.'
CONNECT='false'
source $HOME/.connect/ext_vars.cfg

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -c|--connect)
      CONNECT='true'
      shift
      ;;
    -e|--environment)
      ENVIRONMENT="$2"
      shift
      shift
      ;;
    -h|--hosts)
      HOSTS="$2"
      shift
      shift
      ;;
  esac
done

awk -F ";" 'BEGIN{ printf("%-10s %-10s %-80s\n", "Host","Env","Notes")}'
# Read File line by line
while IFS="" read -r p || [ -n "$p" ]
do
  h=`echo "$p" | cut -d";" -f1`
  e=`echo "$p" | cut -d";" -f2`
  h_found=`echo $h| grep -q $HOSTS && echo 0 || echo 1`
  e_found=`echo $e| grep -q $ENVIRONMENT && echo 0 || echo 1`

  if [ "$h_found" -eq "0" ] && [ "$e_found" -eq "0" ];
  then
      echo "$p" | cut -d ";" -f1,2,3 | awk -F ";" '{ printf "%-10s %-10s %-80s\n", $1,$2,$3}'
      if [ "$CONNECT" = "true" ];
      then
        eval `echo "$p &" | cut -d ";" -f4`
      fi
  fi
done < $INVENTORY
