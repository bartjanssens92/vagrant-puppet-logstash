# This class manages the order

class logstash_kibana_elasicsearch {

  include ::packages

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  class { 'apache_ins':}
  ->
  class { 'logstash_ins':}
  ->
  class { 'elasticsearch':
    status   => 'running',
    require  => Class['packages'],
    version  => '0.90.9-1',
  }
  ->
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

  class { 'firewall_ins':}
}