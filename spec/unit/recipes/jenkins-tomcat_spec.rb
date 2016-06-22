require 'spec_helper'

describe 'chef-lamp-jenkins::jenkins-tomcat' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'installs tomcat' do
    expect(chef_run).to install_package 'tomcat'
  end

  it 'starts the tomcat service' do
    expect(chef_run).to start_service 'tomcat'
  end
end
