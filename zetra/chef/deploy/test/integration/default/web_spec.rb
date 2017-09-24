
describe package('tomcat') do
  it { should be_installed }
end

describe service('tomcat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

path = "/var/lib/tomcat/webapps/app.war"
describe file(path) do
  it { should exist }
end
