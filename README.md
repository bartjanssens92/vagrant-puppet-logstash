##How to use this box :

git clone ...
git submodule init
git submodule update
vagrant up
Go to virtualbox and disable the usb controller
vagrant up
goto localhost:8082

##Adding configuration to logstash :

```puppet
  logstash::configfile { 'foo':
    content  => '
      foo {
        ...
      }',
    order    => 10,
  }

```

##Modules :

 - Apache
 - Concat 		(needed for apache)
 - Elasticsearch
 - File_concat 	(needed for logstash)
 - logstash     (version 0.90.9-1)
 - Stdlib 		(needed for logstash)

##Packages:

 - Ruby			(needed for kibana)
 - Rubygems		(needed for kibana)

 ##Vagrant box I used

 http://packages.vstone.eu/vagrant-boxes/centos/6.x/centos-6.x-64bit-puppet.3.x-chef.0.10.x-vbox.4.3.2-1.box

##Yumrepos added:

```puppet
  # Adding the yumrepo for logstash

  yumrepo { 'logstashrepo':
    name      => 'logstash-repository-for-1.3.x-packages',
    descr     => 'logstash-repository-for-1.3.x-packages',
    baseurl   => 'http://packages.elasticsearch.org/logstash/1.3/centos',
    gpgcheck  => 1,
    gpgkey    => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    enabled   => 1,
  }

  # Adding yumrepo for elasticsearch

  yumrepo { 'Elasticsearch repository for 0.90.x packages':
    name      => 'elasticsearch-0.90',
    descr     => 'elasticsearch-0.90',
    baseurl   => 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
    gpgcheck  => 1,
    gpgkey    => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    enabled   => 1,
  }

  # Adding EPEL repo

  yumrepo { 'epel':
    name        => 'epel',
    mirrorlist  => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64',
    enabled     => 1,
    gpgcheck    => 0,
  }
```

##Config for logstash 

I used this in the logstash.pp file to add the content in the /etc/logstash/conf.d/logstash.conf file:

```puppet
#
# Logstash
#

  class { 'logstash':
    ensure         => 'present',
    init_defaults  => $config_hash,
    java_install   => true,
    status         => 'enabled',
    require        => Yumrepo['logstashrepo'],
  }

  logstash::configfile { 'input':
    content  => '
      input {
        syslog {
          type => "syslog"
          port => "5544"
        }
      }',
    order    => 10,
  }

  logstash::configfile { 'output':
    content  => '
      output {
        elasticsearch {
          host  => "localhost"
        }
      }',
    order    => 20,
  }
```

##Rsyslog configuration

```puppet
    file_line { 'Configuring rsyslog':
        path    => '/etc/rsyslog.conf',
        line    => '*.* @localhost:5544',
    }
```