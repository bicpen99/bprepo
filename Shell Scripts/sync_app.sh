#!/bin/bash

echo "This script moves over all Forms and Reports Source and Binaries from Dev to Test, by the application selected."
echo "  1. CASE         "
echo "  2. OGECRS       "
echo "  3. OGMENU       "
echo "  4. OGMOEA       "
echo "  5. PUD          "
echo "  6. TRANS        "
echo "  7. All          "
read -p "Enter the menu number of the application that you wish to build (1-7): " app_name

if [ $app_name == "1" ]; then
  export src_dir="/u01/data/CASE/"
  export app_name="CASE"
elif [ $app_name == "2" ]; then
  export src_dir="/u01/data/OGECRS/"
  export app_name="OGECRS"
elif [ $app_name == "3" ]; then
  export src_dir="/u01/data/OGMENU/"
  export app_name="OGMENU"
elif [ $app_name == "4" ]; then
  export src_dir="/u01/data/OGMOEA/"
  export app_name="OGMOEA"
elif [ $app_name == "5" ]; then
  export src_dir="/u01/data/PUD/"
  export app_name="PUD"
elif [ $app_name == "6" ]; then
  export src_dir="/u01/data/TRANS/"
  export app_name="TRANS"
elif [ $app_name == "7" ]; then
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
