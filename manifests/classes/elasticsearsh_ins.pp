#Class that manages the elasticsearsh config

class elasticsearch_ins {

  class { 'elasticsearch':
    status   => 'running',
    require  => Class['packages'],
    version  => '0.90.9-1',
  }
}