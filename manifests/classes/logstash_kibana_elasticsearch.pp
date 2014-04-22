# This class manages the order

class logstash_kibana_elasicsearch {

  include ::params

  $config_hash = { 'START'  => true, }

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

#
# Apache Config for kibana
#

  class { 'apache': }

  apache::vhost { 'first.example.com':
    port    => '80',
    docroot => '/var/www/first',
  }
  
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

  logstash::configfile { 'logstash.conf':
    content  => $params::logstash_config,
  }
  
#
# Elasticsearch 
#

  class { 'elasticsearch':
    status   => 'running',
    require  => Yumrepo['Elasticsearch repository for 0.90.x packages'],
    version  => '0.90.9-1',
  }
  
#
# Rsyslog config to put all the things to localhost:5544
#

  file_line { 'Configuring rsyslog':
    path    => '/etc/rsyslog.conf',
    line    => '*.* @localhost:5544',
    match   => '\*\.\*\s\@',
    notify  => Service['service rsyslogd restart']
  }

  service { 'service rsyslogd restart':
    name        => 'rsyslog',
    hasrestart  => true,
    restart     => '/sbin/service rsyslog restart',
  }

#
# Firewall
#

  resources { 'firewall':
    purge  => true,
  }

  class { ['pre', 'post']: }

  class { 'firewall': }

  firewall { '100 allow http and https access':
    port     => [22, 80, 9200],
    proto    => tcp,
    action   => accept,
    before   => Class['post'],
    require  => Class['pre'],
  }

  # the firewall pre

  class pre {
    Firewall {
      require  => undef,
    }

    # Default firewall rules
    firewall { '000 accept all icmp':
      proto   => 'icmp',
      action  => 'accept',
    }->
    firewall { '001 accept all to lo interface':
      proto   => 'all',
      iniface => 'lo',
      action  => 'accept',
    }->
    firewall { '002 accept related established rules':
      proto   => 'all',
      ctstate => ['RELATED', 'ESTABLISHED'],
      action  => 'accept',
    }
  }

  # This class manages the post firewall rules

  class post {
    firewall { '999 drop all':
      proto   => 'all',
      action  => 'drop',
      before  => undef,
    }
  }

#
# Kibana VERY DIRTY
#

  exec { 'Getting kibana3':
    command => 'sudo yum install /etc/puppet/files/kibana3-html-1.0-1.x86_64.rpm -y',
    creates => '/var/www/html/build.txt',
  }

#
# Yumrepos
#

  yumrepo { 'logstashrepo':
    name      => 'logstash-repository-for-1.3.x-packages',
    baseurl   => 'http://packages.elasticsearch.org/logstash/1.3/centos',
    gpgcheck  => 1,
    gpgkey    => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    enabled   => 1,
  }

  # Adding yumrepo for elasticsearch

  yumrepo { 'Elasticsearch repository for 0.90.x packages':
    name      => 'elasticsearch-0.90',
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

  package { 'redis':
    ensure  => 'present',
    require => Yumrepo['epel'],
  }

  package { 'ruby': ensure  => 'present'; }
  package { 'rubygems': ensure  => 'present'; }
  package { 'ruby-devel': ensure  => 'present';}
}