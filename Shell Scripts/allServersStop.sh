echo "############################"
echo "# All Servers are STOPPING #"
echo "############################"
export FMW_HOME=/u01/app/oracle/middleware
export DOMAIN_HOME=/u01/app/oracle/user_projects/domains/fr_domain_dev

. $FMW_HOME/wlserver/server/bin/setWLSEnv.sh
. $DOMAIN_HOME/bin/setDomainEnv.sh
#. $DOMAIN_HOME/bin/setStartupEnv.sh

/u01/app/oracle/java/bin/java weblogic.WLST /home/oracle/scripts/StartStop_Scripts/stopOHS1.wlst
/u01/app/oracle/java/bin/java weblogic.WLST /home/oracle/scripts/StartStop_Scripts/allServersStop.py

nohup $DOMAIN_HOME/bin/stopWebLogic.sh > $DOMAIN_HOME/servers/AdminServer/logs/AdminServer.out


nohup $DOMAIN_HOME/bin/stopNodeManager.sh > $DOMAIN_HOME/nodemanager/nodemanager.out


echo "######################################"
echo "# All Servers Stopped Successfully!! #"
echo "######################################"