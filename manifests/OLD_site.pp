# Bart Janssens 19-02-14
# Adding the repo for logstash

yumrepo { 'logstashrepo':

	name 		=> 'logstash-repository-for-1.3.x-packages',
 	baseurl 	=> 'http://packages.elasticsearch.org/logstash/1.3/centos',
 	gpgcheck 	=> 1,
 	gpgkey 		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
 	enabled 	=> 1,
}

# logstash clean

class {'logstash':

	java_install 	=> true,
	status			=> 'running',

}

# Adding yumrepo for elasticsearch

yumrepo { 'Elasticsearch repository for 0.90.x packages':

	name		=> 'elasticsearch-0.90',
	baseurl		=> 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
	gpgcheck	=> 1,
	gpgkey		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
	enabled		=> 1,

}

# elasticsearch clean

class { 'elasticsearch': } 

# ruby needed for kibana i think...

package {"ruby":  ensure => present; }

yumrepo { 'monitoringsucks': 

	name		=> 'MonitoringSuck at Inuits',
	baseurl		=> 'http://pulp2.internal.inuits.eu/pulp/repos/pub/monitoring',
	enabled		=> 1,
	gpgcheck	=> 0,
	
}

# kibana clean

#class { 'kibana':

	status		=> 'enabled',

 }