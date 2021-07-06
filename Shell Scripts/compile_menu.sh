#!/bin/bash

export TERM=vt220
export ORACLE_TERM=vt220
export ORACLE_HOME=/u01/app/oracle/middleware
export DOMAIN_HOME=/u01/app/oracle/user_projects/domains/fr_domain_dev
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/jdk/jre/bin/client:$ORACLE_HOME/jdk/bin:$PATH
export FR_INST=$ORACLE_HOME
CLASSPATH=/u01/app/oracle/middleware/jlib/frmbipc.jar:/u01/app/oracle/middleware/forms/j2ee/frmsrv.jar:/u01/app/oracle/middleware/forms/provision/frmconfig.jar:/u01/app/oracle/middleware/jlib/ldapjclnt11.jar:/u01/app/oracle/middleware/jlib/debugger.jar:/u01/app/oracle/middleware/oracle_common/jlib/ewt3.jar:/u01/app/oracle/middleware/oracle_common/modules/oracle.bali.share/share.jar:/u01/app/oracle/middleware/jlib/utj.jar:/u01/app/oracle/middleware/jlib/zrclient.jar:/u01/app/oracle/middleware/reports/jlib/rwrun.jar:/u01/app/oracle/middleware/forms/java/frmwebutil.jar:/u01/app/oracle/middleware/oracle_common/modules/oracle.jps/jps-manifest.jar:/u01/app/oracle/middleware/oracle_common/modules/oracle.dms/dms.jar:/u01/app/oracle/middleware/oracle_common/modules/oracle.odl/ojdl.jar:/u01/app/oracle/middleware/oracle_common/modules/javax.management.j2ee.jar

LD_LIBRARY_PATH=/u01/app/oracle/middleware/lib:/u01/app/oracle/java/jre/lib/amd64:/u01/app/oracle/java/jre/lib/amd64/server:/u01/app/oracle/java/jre/lib/amd64/native_threads

export FORMS_INSTANCE=/u01/app/oracle/user_projects/domains/fr_domain_dev/config/fmwconfig/components/FORMS/instances/forms1

export TNS_ADMIN=/u01/app/oracle/user_projects/domains/fr_domain_dev/config/fmwconfig

echo "This script compiles all forms, menus and shared libraries for a specific application"
echo "	1. CASE		"
echo "	2. OGECRS	"
echo "	3. OGMENU	"
echo "	4. OGMOEA	"
echo "	5. PUD		"
echo "	6. TRANS	"
read -p "Enter the menu number of the application that you wish to compile (1-6): " app_name

  if [ $app_name == "1" ]; then
    export DB_USER=P01
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devap01
    export FORMS_PATH=/u01/data/CASE/forms/src
    export OUTPUT_PATH=/u01/data/CASE/forms/bin
    echo "Variables set for CASE"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  elif [ $app_name == "2" ]; then
    export DB_USER=G00
    export DB_PASSWD=Occ185_Oci#
    export DB_SERVICE=devog01
    export FORMS_PATH=/u01/data/OGECRS/forms/src
    export OUTPUT_PATH=/u01/data/OGECRS/forms/bin
    echo "Variables set for OGECRS"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  elif [ $app_name == "3" ]; then
    export DB_USER=D53
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devog01
    export FORMS_PATH=/u01/data/OGMENU/forms/src
    export OUTPUT_PATH=/u01/data/OGMENU/forms/bin  
    echo "Variables set for OGMENU"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  elif [ $app_name == "4" ]; then
    export DB_USER=C01
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devog01
    export FORMS_PATH=/u01/data/OGMOEA/forms/src
    export OUTPUT_PATH=/u01/data/OGMOEA/forms/bin
    echo "Variables set for OGMOEA"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  elif [ $app_name == "5" ]; then
    export DB_USER=V99
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devap01
    export FORMS_PATH=/u01/data/PUD/forms/src
    export OUTPUT_PATH=/u01/data/PUD/forms/bin
    echo "Variables set for PUD"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  elif [ $app_name == "6" ]; then
    export DB_USER=T01
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devap01
    export FORMS_PATH=/u01/data/TRANS/forms/src
    export OUTPUT_PATH=/u01/data/TRANS/forms/bin 
    echo "Variables set for TRANS"
    cd $OUTPUT_PATH
    echo "Cleaning up old compiled Menus"
    rm *.mmx
  fi

# Menus
cd $FORMS_PATH
for FILE in `ls *.mmb`; do
  OUTPUT=${FILE/mmb/mmx}
  echo "Compiling Menu $FILE..."
  $ORACLE_HOME/bin/frmcmp_batch $FILE $DB_USER/$DB_PASSWD@$DB_SERVICE module_type=menu batch=yes output_file=$OUTPUT_PATH/$OUTPUT compile_all=special
done

