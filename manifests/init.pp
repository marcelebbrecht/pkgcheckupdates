# Class: pkgcheckupdates
# ===========================
#
# Full description of class pkgcheckupdates here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'pkgcheckupdates':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class pkgcheckupdates {
	file {
		"/opt/puppet":
			ensure => 'directory',
                        owner => 'root',
                        group => 'root',
                        mode => '0755',
	}

	file {
		"/opt/puppet/bin":
			ensure => 'directory',
                        owner => 'root',
                        group => 'root',
                        mode => '0755',
	}

	file {
		"pkg_check_updates":
			ensure => 'file',
			content => "#!/usr/bin/bash
PATH='/usr/bin:/usr/sbin'
LANG=C

STATE=\$(/usr/bin/pkg update -n | grep 'No updates available for this image' | wc -l)

if [ \$STATE -eq 1 ]; then
        printf no > /tmp/pkgcheckupdates
else
        printf yes > /tmp/pkgcheckupdates
fi

exit 0
",
			path => '/opt/puppet/bin/pkg_check_updates.sh',
			owner => 'root',
			group => 'root',
			mode => '0755',
	}

	exec {
		"pkg-update":
			command => '/opt/puppet/bin/pkg_check_updates.sh',
			timeout => 60,
	}
}
