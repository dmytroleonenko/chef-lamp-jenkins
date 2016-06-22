# firewall
default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true

# SSL
#default['chef-lamp-jenkins']['default']['common_name'] = 'jenkins.ciklum.int'
#default['chef-lamp-jenkins']['default']['ssl_cert']['source'] = 'self-signed'
#default['chef-lamp-jenkins']['default']['ssl_key']['source'] = 'self-signed'
#default['chef-lamp-jenkins']['default']['ssl_cert']['path'] = '/etc/ssl/certs/selfsigned.crt'
#default['chef-lamp-jenkins']['default']['ssl_key']['path'] = '/etc/ssl/certs/selfsigned.key'

# httpd
default['chef-lamp-jenkins']['httpd_user'] = 'apache'
default['chef-lamp-jenkins']['httpd_group'] = 'apache'
default['chef-lamp-jenkins']['httd_docroot'] = '/var/www/html'
default['chef-lamp-jenkins']['httpd_ports'] = [80, 443]

# SELinux
default['chef-lamp-jenkins']['selinux']['booleans'] = { httpd_can_network_connect: 'on', httpd_enable_homedirs: 'off' }
