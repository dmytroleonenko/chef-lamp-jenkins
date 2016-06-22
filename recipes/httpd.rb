#Pre-provision selinux contexts for the 'default' httpd instance creation
execute 'semanage fcontext -a -e /etc/httpd /etc/httpd-default' do
  not_if 'ls -Z /etc/httpd-default | grep -q httpd_config_t'
  action :run
end

httpd_service 'default' do
  mpm 'prefork'
  listen_ports node.default['chef-lamp-jenkins']['httpd_ports']
  action [:create, :start]
end

ssl_certificate 'default' do
  action :create
end

%w{php ssl rewrite proxy proxy_ajp}.each do |mod|
  httpd_module mod do
    action :create
  end
end

phpinfo_path = "#{node['chef-lamp-jenkins']['httd_docroot']}/phpinfo.php"
file phpinfo_path do
  content '<?php phpinfo(); ?>'
  mode '0644'
  owner 'root'
  group 'root'
end

httpd_config 'default' do
  instance 'default'
  source 'httpd.conf.erb'
  
  notifies :restart, 'httpd_service[default]'
end

