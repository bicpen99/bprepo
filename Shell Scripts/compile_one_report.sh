#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/middleware
export DOMAIN_HOME=/u01/app/oracle/user_projects/domains/fr_domain_dev
export LD_LIBRARY_PATH=/u01/app/oracle/middleware/oracle_common/jdk/jre/lib/amd64/server:/u01/app/oracle/middleware/oracle_common/jdk/jre/lib/amd64:/u01/app/oracle/middleware/oracle_common/jdk/jre/../lib/amd64:/u01/app/oracle/middleware/oracle_common/jdk/jre/lib/amd64/native_threads:/u01/app/oracle/middleware/oracle_common/jdk/jre/lib/amd64:/u01/app/oracle/middleware/lib:/u01/app/oracle/middleware/oracle_common/jdk/jre/lib/amd64/server:/u01/app/oracle/middleware/reports/../lib::/u01/app/oracle/middleware::/u01/app/oracle/middleware/wlserver/server/native/linux/x86_64:/u01/app/oracle/middleware/wlserver/server/native/linux/x86_64/oci920_8

export RW=/u01/app/oracle/middleware/reports
export REPORTS_TAGLIB_URI=/WEB-INF/lib/reports_tld.jar
export REPORTS_TMP=/tmp
export REPORTS_NO_DUMMY_PRINTER=TRUE
export REPORTS_CLASSPATH=$ORACLE_HOME/reports/jlib/rwbuilder.jar:$ORACLE_HOME/reports/jlib/rwrun.jar:$ORACLE_HOME/jlib/zrclient.jar
export TK_ICON=$ORACLE_HOME/reports/plugins/resource
export REPORTS_DEFAULT_DISPLAY=YES
export CA_GPREFS=$DOMAIN_HOME/config/fmwconfig/components/ReportsToolsComponent/reptools1/tools/admin
export CA_UPREFS=$DOMAIN_HOME/config/fmwconfig/components/ReportsToolsComponent/reptools1/tools/admin
export PATH=$CA_GPREFS:$PATH

echo "This script compiles one report for a specific application."
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
    export REPORTS_PATH=/u01/data/CASE/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/CASE/reports/src
    export REPORTS_OUTPUT=/u01/data/CASE/reports/bin
    cd $REPORTS_OUTPUT
    echo "Variables set for CASE"
    echo "Cleaning up old compiled reports..."
    rm -rf *.rep
    cd $REPORTS_FOLDER
    rm -rf *.rep
  elif [ $app_name == "2" ]; then
    export DB_USER=G00
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devog01
    export REPORTS_PATH=/u01/data/OGECRS/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/OGECRS/reports/src
    export REPORTS_OUTPUT=/u01/data/OGECRS/reports/bin
    echo "Variables set for OGECRS"
    echo "Cleaning up old compiled reports..."
    rm -rf *.rep
    cd $REPORTS_FOLDER
    rm -rf *.rep
  elif [ $app_name == "3" ]; then
    export DB_USER=D53
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devog01
    export REPORTS_PATH=/u01/data/OGMENU/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/OGMENU/reports/src
    export REPORTS_OUTPUT=/u01/data/OGMENU/reports/bin  
    echo "Variables set for OGMENU"
    echo "Cleaning up old compiled reports..."
    rm -rf *.rep
    cd $REPORTS_FOLDER
    rm -rf *.rep
  elif [ $app_name == "4" ]; then
    export DB_USER=C01
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devog01
    export REPORTS_PATH=/u01/data/OGMOEA/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/OGMOEA/reports/src
    export REPORTS_OUTPUT=/u01/data/OGMOEA/reports/bin
    echo "Variables set for OGMOEA"
    echo "Cleaning up old compiled reports..."
    rm -rf *.rep
    cd $REPORTS_FOLDER
    rm -rf *.rep
  elif [ $app_name == "5" ]; then
    export DB_USER=V99
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devap01
    export REPORTS_PATH=/u01/data/PUD/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/PUD/reports/src
    export REPORTS_OUTPUT=/u01/data/PUD/reports/bin
    echo "Variables set for PUD"
  elif [ $app_name == "6" ]; then
    export DB_USER=T01
    export DB_PASSWD=hO9#Lxw2iBr_iaqaDSN54
    export DB_SERVICE=devap01
    export REPORTS_PATH=/u01/data/TRANS/reports/src:/u01/app/oracle/middleware/reports/templates:/u01/app/oracle/middleware/reports/samples/demo:/u01/app/oracle/middleware/reports/printers:/u01/app/oracle/user_projects/domains/fr_domain_dev/reports/fonts
    export REPORTS_FOLDER=/u01/data/TRANS/reports/src
    export REPORTS_OUTPUT=/u01/data/TRANS/reports/bin
    echo "Variables set for TRANS"
    echo "Cleaning up old compiled reports..."
    #rm -rf *.rep
    cd $REPORTS_FOLDER
    #rm -rf *.rep
  fi

read -p "Enter a report name to compile (include the file extension): " answer
$DOMAIN_HOME/reports/bin/rwconverter.sh userid=$DB_USER/$DB_PASSWD@$DB_SERVICE batch=yes source=$REPORTS_FOLDER/$answer stype=rdffile dtype=repfile overwrite=yes compile_all=yes


echo "Moving Compiled Reports to bin directory..."
cd $REPORTS_FOLDER
mv *.rep ../bin/.

echo "Done!"

