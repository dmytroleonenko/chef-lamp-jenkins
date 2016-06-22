package 'tomcat'

service 'tomcat' do
  action [:enable, :start]
end

remote_file '/usr/share/tomcat/webapps/jenkins.war' do
  source 'http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war'
  action :create
end
