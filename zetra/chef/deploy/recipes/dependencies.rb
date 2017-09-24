package 'tomcat' do
  action :install
end

service 'tomcat' do
 supports :status => true, :restart => true, :reload => true
 action :enable
end