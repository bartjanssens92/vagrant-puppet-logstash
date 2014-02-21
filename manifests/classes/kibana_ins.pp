#class for installing and config off kibana

class kibana_ins {

	package { "ruby": ensure	=> present; }
	
	package { "rubygems": ensure => present; }

	#class { "kibana": }

}

