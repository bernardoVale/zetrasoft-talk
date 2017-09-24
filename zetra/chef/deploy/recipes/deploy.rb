directory '/var/lib/tomcat/webapps/app' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :nothing
  recursive true
end

remote_file "#{node['deploy']['tomcat']['home']}/app.war" do
  source "#{node['deploy']['artifact']['url']}/#{node['deploy']['artifact']['name']}"
  owner node['deploy']['tomcat']['user']
  group node['deploy']['tomcat']['group']
  mode '0640'
  checksum node['artifact_checksum']
  action :create
  notifies :restart, 'service[tomcat]', :delayed
  notifies :delete, 'directory[/var/lib/tomcat/webapps/app]', :immediately
end
