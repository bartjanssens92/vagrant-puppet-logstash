# Bart Janssens 19-02-14

# Adding the repo for logstash

class logstash_repos {

	yumrepo { 'logstashrepo':

		name 		=> 'logstash-repository-for-1.3.x-packages',
	 	baseurl 	=> 'http://packages.elasticsearch.org/logstash/1.3/centos',
	 	gpgcheck 	=> 1,
	 	gpgkey 		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
	 	enabled 	=> 1,
	}

	# Adding yumrepo for elasticsearch

	yumrepo { 'Elasticsearch repository for 0.90.x packages':

		name		=> 'elasticsearch-0.90',
		baseurl		=> 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
		gpgcheck	=> 1,
		gpgkey		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
		enabled		=> 1,

	}

	# Adding repo for kibana

#	yumrepo { 'monitoringsucks': 
#	
#		name		=> 'MonitoringSuck-at-Inuits',
#		baseurl		=> 'http://pulp2.internal.inuits.eu/pulp/repos/pub/monitoring',
#		enabled		=> 1,
#		gpgcheck	=> 0,
#		
#	}

	# Adding EPEL repo

	yumrepo {'epel': 

		name		=> 'epel',
		mirrorlist	=> 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64',
		enabled		=> 1,
		gpgcheck	=> 0,
	
	}
}