#Class that manages the elasticsearsh config

class elasticsearch_ins {

	class { 'elasticsearch': 

		status			=> 'running',
		require 		=> Yumrepo['elasticsearch-0.90'],

	}
	 
}