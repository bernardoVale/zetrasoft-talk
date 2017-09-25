Setup ruby env

```
rvm install 2.4.0
```

Create cookbook:

```
chef generate cookbook deploy
```

Change .kitchen.yml:
```yml
---
driver:
  name: docker
  use_sudo: false

provisioner:
  name: chef_solo

verifier:
  name: inspec

platforms:
  - name: centos-7.2
    driver_config:
      image: centos/systemd
      run_command: /usr/sbin/init
      privileged: true
      forward: 
        - 8082:8080
      provision_command:
        - sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
        - systemctl enable sshd.service
      privileged: true
      volume:
        - /sys/fs/cgroup:/sys/fs/cgroup
      cap_add:
        - SYS_PTRACE

verifier:
  name: inspec

suites:
  - name: default
    run_list:
      - recipe[deploy::default]
    verifier:
      inspec_tests:
        - test/integration/default
    attributes:
      artifact_checksum: 409b59a8b275f57eb8f7eb7c12e293eefd1f8e64e165a25b3d8501c1b870378f
```

Create gemfile:
```ruby
source 'https://rubygems.org'

gem 'berkshelf', '~> 4.0'
gem 'test-kitchen', '~> 1.4'
gem 'kitchen-docker'
gem 'kitchen-inspec'
gem 'concurrent-ruby', '~> 0.9'
gem 'inspec'
gem 'foodcritic'
```

Create instance:
```
kitchen create
```

Create tests:
```
mkdir -p test/integration/default
touch test/integration/default/web_spec.rb
```

```ruby
describe package('tomcat') do
  it { should be_installed }
end

describe service('tomcat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
```

Create recipe `base.rb`:

```ruby
package 'tomcat' do
  action :install
end

service 'tomcat' do
 supports :status => true, :restart => true, :reload => true
 action :enable
end
```

Add base as a dependency in `default.rb`:

```ruby
include_recipe 'deploy::dependencies'
```

kitchen converge && kitchen verify

Add http test app_spec.rb:
```ruby
describe http('http://localhost:8082/app/', method: 'GET') do
  its('status') { should eq 200 }
  its('body') { should eq 'Hello ZetraSoft v2' }
end
```

Create attributes.rb
```
mkdir attributes
```

attributes.rb:
```ruby
default['deploy']['artifact']['url'] = 'https://s3.amazonaws.com/ac-zetra-deploy'
default['deploy']['artifact']['name'] = 'zetra.war'

default['artifact_checksum'] = '0885628bfba9560288766852f26affb1bbb56ddc8c24ce0114f6d668d96e270d'

# Tomcat package name
default['deploy']['tomcat']['user'] = 'tomcat'
default['deploy']['tomcat']['group'] = 'tomcat'
default['deploy']['tomcat']['home'] = '/var/lib/tomcat/webapps'
```

deploy.rb:
```ruby
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
```

Update kitchen.yml checksum:
```kitchen.yml
attributes:
      artifact_checksum: 409b59a8b275f57eb8f7eb7c12e293eefd1f8e64e165a25b3d8501c1b870378f
```