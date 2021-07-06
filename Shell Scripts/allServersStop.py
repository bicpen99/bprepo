connect('weblogic','WjZme88oDxceSUfrUcF','t3://dev-wls-01.app1.main.oraclevcn.com:7001')
exitonerror=false

# Stop all managed Servers
print "** Stopping WLS_FORMS**"
shutdown('WLS_FORMS','Server', force="true")

print "** Stopping WLS_REPORTS **"
shutdown('WLS_REPORTS','Server', force="true")

print "** Stopping WLS_ORDS **"
shutdown('WLS_ORDS','Server', force="true")

exit()