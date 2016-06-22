def gen_pw
  require 'securerandom'
  SecureRandom.base64(14)
end

mysql_root_pw = gen_pw

#Pre-provision selinux contexts for a subsequent mysql instance creation
execute 'semanage fcontext -a -e /etc/my.cnf.d /etc/mysql-default' do
  not_if 'ls -Z /etc/mysql-default | grep -q mysqld_etc_t'
  action :run
end

execute 'semanage fcontext -a -e /var/lib/mysql /var/lib/mysql-default' do
  not_if 'ls -Z /var/lib/mysql-default | grep -q mysqld_db_t'
  action :run
end

mysql_service 'default' do
  port '3306'
  bind_address '127.0.0.1'
  version '5.6'
  initial_root_password mysql_root_pw
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

file '/root/.my.cnf' do
  mode '0600'
  action :create_if_missing
  content <<-EOF
    [client]
    host     = localhost
    user     = root
    password = #{mysql_root_pw}
    socket   = /var/run/mysql-default/mysqld.sock
    
    [mysql_upgrade]
    host     = localhost
    user     = root
    password = #{mysql_root_pw}
    socket   = /var/run/mysql-default/mysqld.sock
  EOF
end
