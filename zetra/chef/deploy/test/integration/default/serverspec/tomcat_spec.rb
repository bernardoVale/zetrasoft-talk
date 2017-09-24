require 'spec_helper'

describe package('tomcat') do
  it { should be_installed }
end