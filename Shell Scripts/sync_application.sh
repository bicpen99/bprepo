#!/bin/bash

if [ $1 == "CASE" ]; then
  export src_dir="/u01/data/CASE/"
  export app_name="CASE"
elif [ $1 == "OGECRS" ]; then
  export src_dir="/u01/data/OGECRS/"
  export app_name="OGECRS"
elif [ $1 == "OGMENU" ]; then
  export src_dir="/u01/data/OGMENU/"
  export app_name="OGMENU"
elif [ $1 == "OGMOEA" ]; then
  export src_dir="/u01/data/OGMOEA/"
  export app_name="OGMOEA"
elif [ $1 == "PUD" ]; then
  export src_dir="/u01/data/PUD/"
  export app_name="PUD"
elif [ $1 == "TRANS" ]; then
  export src_dir="/u01/data/TRANS/"
  export app_name="TRANS"
elif [ $1 == "ALL" ]; then
  export src_dir="/u01/data/"
  export app_name="All Apps"
else
  echo "Invalid option selected!! Script is exiting!"
  exit
fi

echo "Syncing Host 1 on Test for "$app_name
/usr/bin/rsync --delay-updates -F --compress --archive --rsh='/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --rsync-path='rsync' --out-format='%i %n%L' $src_dir test-wls-01.app1.main.oraclevcn.com:$src_dir

echo "Syncing Host 2 on Test for "$app_name
/usr/bin/rsync --delay-updates -F --compress --archive --rsh='/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --rsync-path='rsync' --out-format='%i %n%L' $src_dir test-wls-02.app1.main.oraclevcn.com:$src_dir
