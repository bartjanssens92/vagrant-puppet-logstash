# This class manages the apache config

class apache_ins {

  class { 'apache': }

  apache::vhost { 'first.example.com':
    port    => '80',
    docroot => '/var/www/first',
  }
}