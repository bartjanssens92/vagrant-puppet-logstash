node 'logstash' {

	include ::logstash_repos

	include ::kibana_ins
		
	include ::logstash_ins
	
	include ::elasticsearch_ins

	#@@@@@@@@@@#
	#@ Apache @#
	#@@@@@@@@@@#
	
	class { 'apache': }

	# redis

	package {"redis": 

		ensure		=> 'present',
		status		=> 'running',
		require 	=> Yumrepo['epel'],	

	}

	# Start all the things

	#service { "redis": enable 	=> true; }

	
}