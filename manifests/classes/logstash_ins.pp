#This class configures Logsash to run on boot

class logstash_ins {

  include ::params

  class { 'logstash':
    ensure         => 'present',
    init_defaults  => $params::config_hash,
    java_install   => true,
    status         => 'enabled',
    require        => Class['packages'],
  }

  logstash::configfile { 'logstash.conf':
    content  => $params::logstash_config,
  }
}