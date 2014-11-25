Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :default do |default_config|

       default_config.vm.box = "centos6-p"
       default_config.vm.box_url = "http://packages.vstone.eu/vagrant-boxes/centos-6.x-64bit-latest.box"

       default_config.vm.network  :hostonly, "10.42.42.20" # change for reasons was 51
       default_config.vm.share_folder "PuppetFiles", "/etc/puppet/files", "puppet-files"

       default_config.ssh.max_tries = 100
       default_config.vm.host_name = "logstash"

       default_config.vm.forward_port  80, 8082 # for Apache
       default_config.vm.forward_port  9200, 9200 # for Kibana3
       default_config.vm.forward_port  3355, 3355 # for Kibana3

#       default_config.vm.provider "virtualbox" do |vb|
#         vb.customize ["modifyvm", :id, "--usb", "off"]
#         vb.customize ["modifyvm", :id, "--usbehci", "off"]
#       end

       default_config.vm.provision :puppet do |default_puppet|
       		default_puppet.manifests_path = "manifests"
       		default_puppet.module_path = "modules"
       		default_puppet.manifest_file = "site.pp"
      		#default_puppet.options = "--verbose --debug" # added for debugging
       end
  end
end
