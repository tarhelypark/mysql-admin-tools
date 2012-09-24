#
# Cookbook Name:: mysql-admin-tools
# Recipe:: default
#
# Copyright 2012, CodePlay Solutions Ltd. - tarhelypark.hu
#
# All rights reserved - Do Not Redistribute
#

package 'bc'

mysqlsla_name = 'mysqlsla-' + node[:mysql_admin_tools][:mysqlsla_version]
mysqlsla_filename = 'mysqlsla-' + node[:mysql_admin_tools][:mysqlsla_version] + '.tar.gz'
mysqlsla_link = node[:mysql_admin_tools][:mysqlsla_url] + mysqlsla_filename
mysqltuner_link = node[:mysql_admin_tools][:mysqltuner_url]
mysqlprimer_link = node[:mysql_admin_tools][:mysqlprimer_url]

remote_file "/tmp/#{mysqlsla_filename}" do
  source mysqlsla_link
  not_if { File.exists?("/usr/local/bin/mysqlsla")}
end

bash "install #{mysqlsla_name}" do
  user "root"
  cwd "/tmp"
  not_if { File.exists?("/usr/local/bin/mysqlsla")}
  code <<-EOH
  tar -zxf #{mysqlsla_filename}
  cd #{mysqlsla_name}
  perl Makefile.PL
  make
  make install
  EOH
end

remote_file "/usr/local/bin/mysqltuner.pl" do
  source mysqltuner_link
  mode "0755"
end

remote_file "/usr/local/bin/tuning-primer.sh" do
  source mysqlprimer_link
  mode "0755"
end

cookbook_file "/etc/logrotate.d/mysql" do
  source "mysql"
  backup false
  owner "root"
  group "root"
  mode "0644"
end

if node[:mysql_admin_tools][:mysqlsla_cron]
  bash "Change logrotate extension config" do
    code <<-EOH
      sed -i'' -e's/dateext/#dateext/' /etc/logrotate.conf
    EOH
    not_if "grep '#dateext' /etc/logrotate.conf"
  end
  
  cookbook_file "/etc/cron.d/mysqlsla" do
    source "mysqlsla.cron"
    backup false
    owner "root"
    group "root"
    mode "0644"
  end
end
