# This class manages the firewall with the firewall module

class firewall_ins {
  resources { 'firewall':
    purge  => true,
  }

  class { ['pre', 'post']: }

  class { 'firewall': }

  firewall { '100 allow http and https access':
    port    => [22, 80, 9200, 3514],
    proto   => tcp,
    action  => accept,
    before   => Class['post'],
    require  => Class['pre'],
  }
}