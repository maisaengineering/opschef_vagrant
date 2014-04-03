
log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               "#{File.expand_path File.dirname(__FILE__)}/admin.pem"
validation_client_name   'chef-validator'
validation_key           "#{File.expand_path File.dirname(__FILE__)}/chef-validator.pem"
validation_key_path      "#{File.expand_path File.dirname(__FILE__)}/chef-validator.pem"
chef_server_url          'https://192.168.50.101'
# syntax_check_cache_path  '.chef/syntax_check_cache'
cookbook_path ["cookbooks", "site-cookbooks"]
knife["nodename"] = "chef_server"
