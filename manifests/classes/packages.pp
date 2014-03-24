# Here are the packages needed

class packages {

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

  yumrepo {'epel':

    name        => 'epel',
    mirrorlist  => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64',
    enabled     => 1,
    gpgcheck    => 0,

  }

  package { 'redis':
    ensure  => 'present',
    require => Yumrepo['epel'],
  }

  package { 'man': ensure  => 'present'; }

  package { 'lsof': ensure  => 'present'; }

  package { 'vim-enhanced':
    ensure   => 'present',
    require  => Yumrepo['epel'],
  }

  package { 'ntp': ensure  => 'present';}

  package { 'ruby': ensure  => 'present'; }

  package { 'rubygems': ensure  => 'present'; }

  package { 'unzip': ensure  => 'present';}

  package { 'ruby-devel': ensure  => 'present';}

  package { 'curl': ensure  => 'present';}
}