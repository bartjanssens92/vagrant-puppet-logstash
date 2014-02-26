# Class for opening the required ports
# In the case of logstash ports 80, 9200 an 3514
# stdlib is needed for the file_line class

class opening_ports {
	
	file_line { 'Opening Ports 22, 80, 9200, 3514':
      	path 	=> '/etc/sysconfig/iptables',
      	line 	=> '-A INPUT -m state --state NEW -m tcp -p tcp -m multiport --dports 22,80,9200 -j ACCEPT',
      	match	=> '\-[A]\s[A-Z]{5}\s\-[m]\s[a-z]{5}\s\-{2}[a-z]{5}\s[A-Z]{3}\s\-[m]\s[t,c,p]{3}\s\-[p]\s[t,p,c]{3}\s'
    }

	exec { 'service iptables restart':
		path 	=> '/sin',
		command => '/sbin/service iptables restart',
	}

}