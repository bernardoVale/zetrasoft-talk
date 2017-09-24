describe http('http://localhost:8082/app/', method: 'GET') do
  its('status') { should eq 200 }
  its('body') { should eq 'Hello ZetraSoft v1' }
end