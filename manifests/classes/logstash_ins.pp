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
	
	syslog {
	type => "syslog"
    	port => "3355"
	}

  	#file {
    #	path => "/var/log/messages"
    #	type => "syslog"
  	#}

  	#file {
    #	path => "/var/log/apache/access.log"
    #	type => "apache"
  	#}
}

#filter {
#	grok {
#        type => "apache-error"
#        pattern => "\[%{HTTPDATE:timestamp}\] \[%{WORD:class}\] \[%{WORD:originator} %{IP:clientip}\] %{GREEDYDATA:errmsg}"
#    }
#}

output {
#	stdout {}
	elasticsearch {}
} 
		')
	}
}