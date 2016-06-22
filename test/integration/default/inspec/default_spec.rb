# Packages
describe package 'tomcat' do
  it { should be_installed }
end

describe package 'mysql-community-server' do
  it { should be_installed }
end

describe package 'httpd' do
  it { should be_installed }
end



# Services
describe service 'tomcat' do
  it { should be_enabled }
  it { should be_running }
end

describe service 'mysql-default' do
  it { should be_enabled }
  it { should be_running }
end

describe service 'httpd-default' do
  it { should be_enabled }
  it { should be_running }
end




# Serivce behaviour

## MySQL
describe command 'mysql -e "show databases"' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /information_schema/ }
end

## phpinfo()
describe command 'curl -k http://localhost/' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /allow_url_fopen/ }
end

describe command 'curl -k https://localhost/' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /allow_url_fopen/ }
end

## /jenkins

describe command 'curl -kL http://localhost/jenkins' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /Jenkins/ }
end
### http->https
describe command 'curl -I http://localhost/jenkins' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /https/ }
  its('stdout') { should match /301 Moved Permanently/ }
end


