 class kibana_tmp {

 	exec { 'wget kibana':

 		command	=> '/usr/bin/wget https://github.com/elasticsearch/kibana/archive/master.zip',

 	}

 } 
