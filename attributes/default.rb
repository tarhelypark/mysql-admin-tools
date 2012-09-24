default[:mysql_admin_tools][:mysqlsla_version] = '2.03'
default[:mysql_admin_tools][:mysqlsla_url] = 'http://hackmysql.com/scripts/'
default[:mysql_admin_tools][:mysqltuner_url] = ''

default[:mysql_admin_tools][:mysqltuner_url] = 'https://raw.github.com/rackerhacker/MySQLTuner-perl/master/mysqltuner.pl'

default[:mysql_admin_tools][:mysqlprimer_version] = '1.6-r1'
default[:mysql_admin_tools][:mysqlprimer_url] = "https://launchpad.net/mysql-tuning-primer/trunk/#{node[:mysql_admin_tools][:mysqlprimer_version]}/+download/tuning-primer.sh"
