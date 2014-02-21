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

-- Gitlog atm

Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Fri Feb 21 17:15:44 2014 +0100

    Added README for furder reference

commit 6c4387259c814b404e143ec0b0a050cab02305b8
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Fri Feb 21 16:23:05 2014 +0100

    Fixed the config for logstash, still needs work

commit e81ded74075be0314ff81062166d5aef065d5db3
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Fri Feb 21 09:58:09 2014 +0100

    All the modules are installing, fixed missing repos

commit 002d0eed3ec8f66e24a9c3f20578d04c77ebaae8
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Thu Feb 20 19:27:27 2014 +0100

    Added the remeining modules

commit 296b881671c909361f088902c43e18956c466232
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Thu Feb 20 17:38:12 2014 +0100

    Commit Remodeling the Manifests folder

commit 5c827b01a7e991415f18669d08caf13168e374da
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Thu Feb 20 14:44:44 2014 +0100

    first commit
