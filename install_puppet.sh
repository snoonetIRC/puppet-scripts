#!/bin/bash
service puppet stop >/dev/null 2>&1
apt-get remove -qq puppet-agent
rm -rf /opt/puppetlabs >/dev/null 2>&1
rm -rf /etc/puppetlabs >/dev/null 2>&1
rm -rf /var/run/puppetlabs  >/dev/null 2>&1
codename=`lsb_release --codename | cut -f2`
PUPPET_DEB="puppet-platform.deb"
wget -O $PUPPET_DEB https://apt.puppetlabs.com/puppet5-release-$codename.deb
dpkg -i $PUPPET_DEB
rm -f $PUPPET_DEV
apt-get update
apt-get install puppet-agent
echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf
echo "server = puppet.snoonet.org" >> /etc/puppetlabs/puppet/puppet.conf
echo "environment = production" >> /etc/puppetlabs/puppet/puppet.conf
echo "runinterval = 20m" >> /etc/puppetlabs/puppet/puppet.conf
echo "report = true" >> /etc/puppetlabs/puppet/puppet.conf
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
