# Class for configuring rsyslog
# stdlib is needed for the file_line class.

class rsyslog_config {
	
	file_line { 'Configuring rsyslog':

		path	=> '/etc/rsyslog.conf',
		line	=> '*.* @localhost:5544',
		match	=> '\*\.\*\s\@',

	}

	exec { 'service rsyslogd restart':
		path 	=> '/sin',
		command => '/sbin/service rsyslog restart',
	}
}
