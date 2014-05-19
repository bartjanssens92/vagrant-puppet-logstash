class params (

$logstash_config = '
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
}',

$config_hash = { 'START'  => true, }

){

}