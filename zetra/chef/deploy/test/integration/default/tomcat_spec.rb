path = "/tmp/file"
describe file(path) do
  it { should_not exist }
end

describe package('tomcat') do
  it { should be_installed }
end