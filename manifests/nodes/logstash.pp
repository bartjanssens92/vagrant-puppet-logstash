node 'logstash' {

	#include ::update

	include ::logstash_repos

	include ::kibana_ins
		
	include ::logstash_ins
	
	include ::elasticsearch_ins

	include ::opening_ports
	
	class { 'apache': }

	apache::vhost { 'first.example.com':
    	port    => '80',
      	docroot => '/var/www/first',
    }

	# redis

	package {"redis": 

		ensure		=> 'present',
		require 	=> Yumrepo['epel'],	

	}

	package { "man": ensure		=> 'present'; }
	package { "lsof": ensure	=> 'present'; }
	package { "vim-enhanced": ensure 	=> 'present',
					require		=> Yumrepo['epel'],
			}
	package { "ntp": ensure 	=> 'present';}
}