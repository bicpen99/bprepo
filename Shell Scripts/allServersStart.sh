echo "############################"
echo "# All Servers are STARTING #"
echo "############################"
export FMW_HOME=/u01/app/oracle/middleware
export DOMAIN_HOME=/u01/app/oracle/user_projects/domains/fr_domain_dev

nohup $DOMAIN_HOME/bin/startNodeManager.sh > $DOMAIN_HOME/nodemanager/nodemanager.out &

nohup $DOMAIN_HOME/bin/startWebLogic.sh > $DOMAIN_HOME/servers/AdminServer/logs/AdminServer.out &

SERVER=dev-wls-01.app1.main.oraclevcn.com PORT=7001
while !(: < /dev/tcp/$SERVER/$PORT) 2>/dev/null
do
    echo "** Waiting for Admin Server to Start **"
    sleep 30
done

. $FMW_HOME/wlserver/server/bin/setWLSEnv.sh
. $DOMAIN_HOME/bin/setDomainEnv.sh
#. $DOMAIN_HOME/bin/setStartupEnv.sh

/u01/app/oracle/java/bin/java weblogic.WLST /home/oracle/scripts/StartStop_Scripts/allServersStart.py
/u01/app/oracle/java/bin/java weblogic.WLST /home/oracle/scripts/StartStop_Scripts/startOHS1.wlst


nohup curl "http://dev-wls-01.app1.main.oraclevcn.com:9002/reports/rwservlet/startserver"

echo "###########################"
echo "# All Servers are RUNNING #"
echo "###########################"
