node 'logstash' {

	include ::logstash_repos

	include ::kibana_ins
	
	#@@@@@@@@@@#
	#@ Apache @#
	#@@@@@@@@@@#
	
	class { 'apache': }

	# logstash

	class {'logstash':

		ensure			=> 'present',
		java_install 	=> true,
		status			=> running,
		require 		=> yumrepo['logstashrepo'],

	}

	# redis

	package {"redis": 

		ensure		=> 'present',
		status		=> 'running',
		require 		=> yumrepo['epel'],	

	}

	# elasticsearch clean

	class { 'elasticsearch': 

		status		=> 'running',
		require 		=> yumrepo['elasticsearch-0.90'],

	} 
	
	# Start all the things

	service { "redis": enable 	=> true; }
	
}