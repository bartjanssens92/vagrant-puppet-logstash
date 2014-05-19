node 'logstash' {

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

  $config_hash = { 'START'  => true, }

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

#
# Elasticsearch
#

  class { 'elasticsearch':
    status   => 'running',
    require  => Yumrepo['es11'],
    version  => 'latest',
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
    name        => 'rsyslog', hasrestart  => true,
    restart     => '/sbin/service rsyslog restart',
  }

#
# Firewall
#

  firewall{'015 http':
    dport  => '80',
    action => 'accept',
  }

#
# Kibana VERY DIRTY -- for local use only
#

  exec { 'Getting kibana3':
    command => 'sudo yum install /etc/puppet/files/kibana3-html-1.0-1.x86_64.rpm -y',
    creates => '/var/www/html/build.txt',
  }

#
# Yumrepos
#

  # Adding the yumrepo for logstash

  yumrepo { 'logstashrepo':
    name      => 'logstash-repository-for-1.4.x-packages',
    descr     => 'logstash-repository-for-1.4.x-packages',
    baseurl   => 'http://packages.elasticsearch.org/logstash/1.4/centos',
    gpgcheck  => 1,
    gpgkey    => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    enabled   => 1,
  }

  # Adding yumrepo for elasticsearch

  yumrepo { 'es11':
    name      => 'es11',
    descr     => 'elasticsearch-1.0x',
    baseurl   => 'http://packages.elasticsearch.org/elasticsearch/1.1/centos',
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


  # PacketBeat
  include packetbeat
  packetbeat::protocols{'http':
    protocol => 'http',
    ports    => '80, 8080, 8000, 5000, 8002, 9200 , 9300',
  }

  packetbeat::protocols{'mysql':
    protocol => 'mysql',
    ports    => '3306',
  }

  packetbeat::protocols{'redis':
    protocol => 'redis',
    ports    => '6379',
  }

}
