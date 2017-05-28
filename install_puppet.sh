#!/bin/bash
service puppet stop
apt-get remove puppet-agent
rm -rf /opt/puppetlabs
rm -rf /etc/puppetlabs
rm -rf /var/run/puppetlabs
codename=`lsb_release --codename | cut -f2`
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-$codename.deb
dpkg -i puppetlabs-release-pc1-$codename.deb
rm puppetlabs-release-pc1-$codename.deb
apt-get update
apt-get install puppet-agent
echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf
echo "server = puppet.snoonet.org" >> /etc/puppetlabs/puppet/puppet.conf
echo "environment = production" >> /etc/puppetlabs/puppet/puppet.conf
echo "runinterval = 20m" >> /etc/puppetlabs/puppet/puppet.conf
echo "report = true" >> /etc/puppetlabs/puppet/puppet.conf
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
