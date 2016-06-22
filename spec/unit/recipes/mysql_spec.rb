require 'spec_helper'

describe 'chef-lamp-jenkins::mysql' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
    runner.converge(described_recipe)
  end
  before do
    stub_command("ls -Z /etc/mysql-default | grep -q mysqld_etc_t").and_return(false)
    stub_command("ls -Z /var/lib/mysql-default | grep -q mysqld_db_t").and_return(false)
  end
    #runner.converge(described_recipe)

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
