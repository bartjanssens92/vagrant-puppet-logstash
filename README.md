##Packages that are getting installed via puppet:

 - Apache
 - Concat 		(needed for apache)
 - Elasticsearch
 - File_concat 	(needed for logstash)
 - logstash     (version 0.90.9-1)
 - Stdlib 		(needed for logstash)

##Packages that are getting installed via yum:

 - Lsof
 - Man
 - Ntp
 - Ruby			(needed for kibana)
 - Rubygems		(needed for kibana)
 - Unzip        (using for kibana atm, getting the package for k3)
 - Vim-enhanched

##Yumrepos added:

	name 		=> 'logstash-repository-for-1.3.x-packages',
 	baseurl 	=> 'http://packages.elasticsearch.org/logstash/1.3/centos',
 	gpgcheck 	=> 1,
 	gpgkey 		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
 	enabled 	=> 1,

	name		=> 'elasticsearch-0.90',
	baseurl		=> 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
	gpgcheck	=> 1,
	gpgkey		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
	enabled		=> 1,

	name		=> 'epel',
	mirrorlist	=> 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64',
	enabled		=> 1,
	gpgcheck	=> 0,
	
##Config for logstash 

I used this in the logstash_ins.pp file to add the content in the /etc/logstash/conf.d/logstash.conf file:

```puppet
    logstash::configfile { 'logstash_conf':

        content => (' # Config logstash in logstash_ins.pp
            input {

                syslog {
                    type => "syslog"
                    port => "5544"
                }

            }

            output {
                elasticsearch {
                    host    => "localhost"
                }
            }
        '),
    }
```

##Problem with iptables not letting me acces localhost:9292

Needed to add the following rule in /etc/sysconfig/iptables
-A INPUT -m state --state NEW -m tcp -p tcp -m multiport --dports 22, 80, 9200 -j ACCEPT

I used file_line form stdlib to do this for me

```puppet
    file_line { 'Opening Ports 22, 80, 9200':
        path    => '/etc/sysconfig/iptables',
        line    => '-A INPUT -m state --state NEW -m tcp -p tcp -m multiport --dports 22,80,9200 -j ACCEPT',
        match   => '\-[A]\s[A-Z]{5}\s\-[m]\s[a-z]{5}\s\-{2}[a-z]{5}\s[A-Z]{3}\s\-[m]\s[t,c,p]{3}\s\-[p]\s[t,p,c]{3}\s'
    }
```
This replaces the -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT line

##Rsyslog configuration
```puppet
    file_line { 'Configuring rsyslog':
        path    => '/etc/rsyslog.conf',
        line    => '*.* @localhost:5544',
    }
```

##Thing I learned

 - Vagrant
    - Making a vagrant box 
    - Adding the basic boxes
    - Building furder on an existing box
    - Enabeling puppet provisioning
    - Opening the right ports on the guest and sending them to the host

 - Puppet
    - Making a file structure that puppet can use
    - Writing a manuscript
    - Using modules
        - To **allways** read the README.md file 
        - Calling classes
        - Giving a class some parameters
    - Using include
    - Making my own classes
    - Never be afraid to ask questions
    - Using functions from puppet libaries (file_line)
    - Regex
    - ...

 - CentOS
    - Where to start...
    - Iptables
    - pwd
    - vi
    - vim
    - find
    - man
    - yum
    - yum.repos.d
    - lsof
    - service
    - sudo su
    - ssh
    - grep
    - tail -f
    - logger
    - And I'm sure many more...

 - Ubuntu
    - Sublime text 2 :S (gonna change to vim)
    - VirtualBox
    - sudo apt-get
    - Wireless drivers search
    - Pidgin

 - Github
    - git add
    - git status
    - git log
    - git commit
    - git push


The end ;D