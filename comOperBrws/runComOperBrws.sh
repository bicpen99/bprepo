#!/bin/bash
#####################################################################################
# Ver 1.0 2021.02.21  DE0	Initial Version in Bash converted from DOS Script
#
#####################################################################################
#
#-----------------------------------------------------------------------
# this function defines global variables for use throughout the program
#------------------------------------------------------------------------
export ORACLE_HOME=/u01/app/oracle/middleware
export PATH=$ORACLE_HOME/bin:$PATH

function init_vars {
  Stime=`date "+%s"`
  StartTime=`date`
  cobFName=comOperBrws
  curDate=`date "+%m%d%Y"`
  year=`date "+%Y"`
  month=`date "+%m"`
  day=`date "+%d"`
  outfileDate=$year"_"$month"_"$day
  outfile=$outfileDate
  logFile=/home/oracle/scripts/comOperBrws/logs/$cobFName"_"$outfile.log
  prevDate=`date -d "yesterday 13:00" '+%Y_%m_%d'`
}

#-------------------------------------------------------------------------
# this function checks to see if the program has been run already for
# todays date. If it has, the program exits.
#-------------------------------------------------------------------------
function check_daily {
  dlyFile=/home/oracle/scripts/comOperBrws/$outfile"_"$cobFName.dly
 
  if [[ -f "$dlyFile" ]]; then
    echo "================================================================"
    echo "Daily file exists for today, program exiting..."
    echo "================================================================"
    exit
  else
    echo "================================================================"
    echo "Daily file does not exist for today, running program..."
  fi
}

#-----------------------------------------------------------------------------
# This function executes the stored procedure in the DB and looks for SUCCESS
# returned from the stored procedure before continuing.
#-----------------------------------------------------------------------------
function run_stored_proc {
  rm -f $logFile
  echo "Running Stored Procedure load_com_operbrws from OG01 Database..." >> $logFile 	
  /u01/app/oracle/middleware/bin/sqlplus -s d53/hO9#Lxw2iBr_iaqaDSN54@devog01 @/home/oracle/scripts/comOperBrws/runComOperBrwsProc.sql >> $logFile
  dailyFile=`cat $logFile > /home/oracle/scripts/comOperBrws/$outfile"_"$cobFName.dly`
  isSuccess=`grep 'SUCCESS' $logFile`
  isError=`grep 'ERROR' $logFile`

  if [[ "$isSuccess" == "SUCCESS" ]]; then
    oracleResult=$isSuccess
  fi
  if [[ "$isError" == "ERROR" ]]; then
    oracleResult=$isError
    exit
  fi
}

#-------------------------------------------------------------------------------
# This function runs a SQL script to verify hat the Stored Procedure was run
# successfully and updated the rows correctly. It will create a file to be sent
# as an attachment via an email.
#-------------------------------------------------------------------------------
function run_check_script {
  echo "Running SQL Script to verify table..." >> $logFile
  /u01/app/oracle/middleware/bin/sqlplus -s d53/hO9#Lxw2iBr_iaqaDSN54@devog01 @/home/oracle/scripts/comOperBrws/comOperBrws.sql >> $logFile
  cat /home/scripts/comOperbrws/comOperBrws_EXTRACT.txt >> $logfile
}

#-------------------------------------------------------------------------------
# This function completes the timestampingin the logfile and calculates the time
# to run the overall program.
#-------------------------------------------------------------------------------
function complete_comOperBrws {
  Rtime=`date "+%s"`
  EndTime=`date`
  
  echo "Completed ComOperBrws on "$EndTime >> $logFile
  echo "Program execution took" $(( $Rtime - $Stime )) "seconds " >> $logFile
  echo "================================================================" >> $logFile
}

#--------------------------------------------------------------------------------
# This function performs file cleanup of previous runs.
#--------------------------------------------------------------------------------
function clean_up {
  echo $prevDate > /home/oracle/scripts/comOperBrws/prevDate.txt
  yesterdayDate=`cat /home/oracle/scripts/comOperBrws/prevDate.txt`

  if [[ "$yesterdayDate" == $prevDate ]]; then
    delFile=/home/oracle/scripts/comOperBrws/$prevDate"_"$cobFName.dly
    if [[ -f "$delFile" ]]; then
      echo "Deleting $delFile..."
      rm $delFile
    fi
  else
    echo "No file found to delete"
  fi
}

function include_logfile {
  cat $logFile
}

#----------------------------------------------------------------------------------
# Main execution of program...
#----------------------------------------------------------------------------------
function main {
  init_vars
  check_daily
  run_stored_proc
  run_check_script
  complete_comOperBrws
  include_logfile
  clean_up
}

main
exit
