# This class is for the configuration for logstash
# This way my code looks cleaner3

class params {

  $config_hash = { 'START'  => true, }

  $logstash_config = ('
  # Config logstash in logstash_ins.pp /etc/logstash/conf.d/logstash.conf
  input {
    syslog {
      type => "syslog"
      port => "5544"
    }
  }

  output {
    elasticsearch {
      host  => "localhost"
    }
  }
 ')

}