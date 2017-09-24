describe http('http://localhost:8080/app/chef/ping', method: 'GET', open_timeout: 60, read_timeout: 60, ssl_verify: false) do
  its('status') { should eq 200 }
  its('body') { should eq 'Hello Chef deployed war' }
end