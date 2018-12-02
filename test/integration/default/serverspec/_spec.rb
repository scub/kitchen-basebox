# -*- coding: utf-8 -*-
# vim: ft=rb
# What distributions are we supporting (Debian is what im used to)

require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "Fail2Ban" do

  context package('fail2ban') do
    it { should be_installed }
  end

  context service('fail2ban') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

  context file('/etc/fail2ban') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  context file('/etc/fail2ban/fail2ban.d') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  context file('/etc/fail2ban/fail2ban.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    its(:content) { should match /^loglevel = INFO$/ }
    its(:content) { should match /^logtarget = \/var\/log\/fail2ban.log$/ }
    its(:content) { should match /^syslogsocket = auto$/ }
    its(:content) { should match /^socket = \/var\/run\/fail2ban\/fail2ban.sock$/ }
    its(:content) { should match /^pidfile = \/var\/run\/fail2ban\/fail2ban.pid$/ }
    its(:content) { should match /^dbfile = \/var\/lib\/fail2ban\/fail2ban.sqlite3$/ }
    its(:content) { should match /^dbpurgeage = 86400$/ }
  end

  context iptables do
    it { should have_rule('-p tcp -m multiport --dports 22 -j f2b-sshd').with_table('filter').with_chain('INPUT') }
    it { should have_rule('-j RETURN').with_table('filter').with_chain('f2b-sshd') }
  end

end


describe "HavegeD" do
  context package('haveged') do
    it { should be_installed }
  end

  context service('haveged') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end
end

describe "SSH" do
  context package('openssh-server') do
    it { should be_installed }
  end

  context service('ssh') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

  context port(22) do
    it { should be_listening.with('tcp') }
  end

  context command('sshd -f /etc/ssh/sshd_config -t') do
    its(:stderr)      { should_not match /Bad configuration option/ }
    its(:stderr)      { should_not match /bad configuration options/ }
    its(:exit_status) { should eq 0 }
  end
end

describe "IPTables" do
  context iptables do
    it { should have_rule('-P INPUT ACCEPT').with_table('filter') }
    it { should have_rule('-P FORWARD ACCEPT').with_table('filter') }
    it { should have_rule('-P OUTPUT ACCEPT').with_table('filter') }
  end
end
