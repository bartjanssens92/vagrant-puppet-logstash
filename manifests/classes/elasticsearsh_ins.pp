#Class that manages the elasticsearsh config

class elasticsearch_ins {

	class { 'elasticsearch': 

		status							=> 'running',
		require 						=> Yumrepo['elasticsearch-0.90'],
       	config							=> {
        	'node'						=> {
        		'name'					=> 'elasticsearch001'
        	},
        	'index'     				=> {
        		'number_of_replicas'	=> '0',
           		'number_of_shards'   	=> '5'
         	},
         	'network'					=> {
     			'host'               	=> $::ipaddress
         	}
       	}
    }
	 
}