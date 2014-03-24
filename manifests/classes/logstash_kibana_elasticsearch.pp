# This class manages the order

class logstash_kibana_elasicsearch {

  include ::packages

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  class { 'apache_ins':}
  ->
#  exec { 'Move the file for kibana latest':
#    command   => 'cd /var/www &&
#                 rm html -rf
#                 unzip /vagrant/files/kibana-latest.zip &&
#                 mv /var/www/kibana-latest /var/www/html',
#    provider  => 'shell',
#    creates   => '/var/www/html/build.txt'
#  }
#  ->
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

  file_line { 'Opening Ports 22, 80, 9200, 3514':
    path    => '/etc/sysconfig/iptables',
    line    => '-A INPUT -m state --state NEW -m tcp -p tcp -m multiport --dports 22,80,3514,9200,9301 -j ACCEPT',
    match   => '\-[A]\s[A-Z]{5}\s\-[m]\s[a-z]{5}\s\-{2}[a-z]{5}\s[A-Z]{3}\s\-[m]\s[t,c,p]{3}\s\-[p]\s[t,p,c]{3}\s',
    notify  => Service['service iptables restart'],
  }

  service { 'service iptables restart':
    name     => 'iptables',
    restart  => '/sbin/service iptables restart',
  }
}