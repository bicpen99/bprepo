while True:
 try:
  connect('weblogic','WjZme88oDxceSUfrUcF','t3://dev-wls-01.app1.main.oraclevcn.com:7001')
  break

 except:
  sleep(60)

print "** Starting WLS_FORMS**"
start(name="WLS_FORMS", block="true")

print "** Starting WLS_REPORTS **"
start(name="WLS_REPORTS", block="true")

print "** Starting WLS_ORDS **"
start(name="WLS_ORDS", block="true")

exit()