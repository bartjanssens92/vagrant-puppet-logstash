##Packages that are getting installed via puppet:

 - Apache
 - Concat 		(needed for apache)
 - Elasticsearch
 - File_concat 	(needed for logstash)
 - Kibana 		(via ssh tunnel, not working yet)
 - Logstash
 - Stdlib 		(needed for logstash)

##Packages that are getting installed via yum:

 - Ruby			(needed for kibana)
 - Rubygems		(needed for kibana)
 - Unzip        (using for kibana atm, getting the package for k3)

##Yumrepos added:

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
	
##Config for logstash (**WIP**)

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

I used this in the logstash_ins.pp file to add the content in the /etc/logstash/conf.d/logstash.conf file:

logstash::configfile { 'logstash_conf':

        content => (' # Config logstash in logstash_ins.pp
input {
    file {
    type => "syslog"
        host => "0.0.0.0"
        port => "3514"
    }
}
output {
    host => 10.0.0.51
}
        ')
}

##Gitlog atm

commit 45a7572e7cfbe8f62b6aa2c3df2c5248bf066fd0
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Mon Feb 24 17:23:07 2014 +0100

    "Fixed" some stuff

commit 8e379c8ae3e7450d2d256ba8cdf14a46cd0bc3b8
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Mon Feb 24 11:49:00 2014 +0100

    Trying to get the config working

commit 03d449bbda2e1567141d076df02f43678aba633b
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Mon Feb 24 08:38:26 2014 +0100

    Cleanup

commit 0cf5b81ec61224ad2e79150d615c5b6554147be1
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Mon Feb 24 08:35:33 2014 +0100

    Cleanup

commit 21f631c4a6804f616884d06f42618de982660ef9
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Sun Feb 23 14:37:14 2014 +0100

    Updtaing folder for other laptop

commit b7f49a0a8e5a21e707851455388eec15d2485a62
Author: bartjanssens92 <bartjanssens92@gmail.com>
Date:   Fri Feb 21 17:17:40 2014 +0100

    Updated README

commit 4eb115863140df5743c090a82b12fb00ba5066bb
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
