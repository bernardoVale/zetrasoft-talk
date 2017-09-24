remote_file "#{node['deploy']['tomcat']['home']}/app.war" do
  source 'https://s3.amazonaws.com/ac-zetra-deploy/java-chef-test.war'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, 'service[tomcat]', :delayed
end

# docker run -it --cap-add SYS_PTRACE --rm -p 8080:8080 -v "$PWD:/code" bernardovale/pyubuntu

