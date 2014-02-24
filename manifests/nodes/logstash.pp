node 'logstash' {

	#include ::update

	include ::logstash_repos

	include ::kibana_ins
		
	include ::logstash_ins
	
	include ::elasticsearch_ins
	
	class { 'apache': }

	apache::vhost { 'first.example.com':
    	port    => '81',
      	docroot => '/var/www/first',
    }

	# redis

	package {"redis": 

		ensure		=> 'present',
		status		=> 'running',
		require 	=> Yumrepo['epel'],	

	}

	package { "unzip": ensure		=> 'present'; }

	include ::kibana_tmp
	
}