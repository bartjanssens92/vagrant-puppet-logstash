# Bart Janssens 19-02-14

# Installing the modules

# installing apache

#package { "httpd": 
#
#	ensure	=> present,
#	status	=> start,
#
#}

class { 'apache': }

# logstash

class {'logstash':

	ensure			=> 'present',
	java_install 	=> true,
	status			=> running,

}

# redis

package {"redis": 

	ensure		=> 'present',
	status		=> 'running',

}

# elasticsearch clean

class { 'elasticsearch': 

	status		=> 'running',

} 

# kibana clean

package { "ruby": ensure	=> present; }

package { "rubygems": ensure	=> present; }

#class { 'Kibana': }

# Start all the things

service { "redis": enable 	=> true; }
service { "httpd": enable	=> true; }
	#status		=> 'running',