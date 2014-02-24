node 'logstash' {

	include ::logstash_repos

	include ::kibana_ins
		
	include ::logstash_ins
	
	include ::elasticsearch_ins
	
	class { 'apache': }

	# redis

	package {"redis": 

		ensure		=> 'present',
		status		=> 'running',
		require 	=> Yumrepo['epel'],	

	}
	
}