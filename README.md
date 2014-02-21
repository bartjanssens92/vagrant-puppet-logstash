Packages that are getting installed via puppet:

 - Apache
 - Concat 		(needed for apache)
 - Elasticsearch
 - File_concat 	(needed for logstash)
 - Kibana 		(via ssh tunnel, not working yet)
 - Logstash
 - Stdlib 		(needed for logstash)

Packages that are getting installed via yum:

 - Ruby			(needed for kibana)
 - Rubygems		(needed for kibana)

Yumrepos added:

	name 		=> 'logstash-repository-for-1.3.x-packages',
 	baseurl 	=> 'http://packages.elasticsearch.org/logstash/1.3/centos',
 	gpgcheck 	=> 1,
 	gpgkey 		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
 	enabled 	=> 1,

	name		=> 'elasticsearch-0.90',
	baseurl		=> 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
	gpgcheck	=> 1,
	gpgkey		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
	enabled		=> 1,

	name		=> 'epel',
	mirrorlist	=> 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64',
	enabled		=> 1,
	gpgcheck	=> 0,
	
	And the ssh one.
	
Config for logstash (WIP)

a) input = syslog or syslog-pri

e.g

 logstash::input::syslog { '001input-syslog':
    type => 'syslog',
    host => '0.0.0.0',
    port => '3514',
  }

b) output elasticsearch

 logstash::output::elasticsearch_http { '001output-elasticsearch':
    host => $elasticsearch_server,
  }

Not sure how to do this. Got the template working so logstash can enable on startup. 