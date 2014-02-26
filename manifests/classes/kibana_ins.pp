#class for installing and config off kibana

class kibana_ins {

	package { "ruby": ensure	=> present; }
	
	package { "rubygems": ensure	=> present; }

	package { "unzip": ensure	=> present; }

	exec { 'wget kibana':

 		command	=> '/usr/bin/wget  http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip',
 		creates	=> '/home/vagrant/kibana-latest.zip',

 	}

 	exec { 'unzip kibana-latest.zip to kibana-latest':

 		command	=> '/usr/bin/unzip  kibana-latest.zip',
 		require	=> [Exec['wget kibana'],
 					Package['unzip'],
 				   ],
 		creates	=> '/var/www/html/config.js',
 	}

 	exec { 'move kibana-latest to html':

 		command	=> '/bin/mv kibana-latest html',
 		require	=> Exec['unzip kibana-latest.zip to kibana-latest'],
 		creates	=> '/var/www/html/config.js',

 	}

 	exec { 'move html to /var/www':

 		command => '/bin/mv html /var/www',
 		require	=>	Exec['move kibana-latest to html'],
 		creates	=> '/var/www/html/config.js',

 	}

}

