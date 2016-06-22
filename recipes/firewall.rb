firewall 'default' do
  action :install
end

firewall_rule 'http/https' do
  protocol :tcp
  port     node.default['chef-lamp-jenkins']['httpd_ports']
  command  :allow
end

firewall_rule 'ssh' do
  protocol :tcp
  port 22
  command  :allow
end

# add --permanent to firewalld
firewall 'default' do
  action :save
end
