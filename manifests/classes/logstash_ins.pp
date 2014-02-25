#This class configures Logsash to run on boot

class logstash_ins {

	$config_hash = {
		'START' 	=> 'true',
	}
	
	class {'logstash':

		ensure			=> 'present',
		init_defaults 	=> $config_hash,
		java_install 	=> true,
		status			=> 'running',
		require 		=> Yumrepo['logstashrepo'],

	}

	logstash::configfile { 'logstash_conf':

		content	=> (' # Config logstash in logstash_ins.pp
input {
	file {
	type => "syslog"
    	host => "0.0.0.0"
    	port => "3514"
	}
}
output {
	host => 10.0.0.51
}
		')

	}

} 