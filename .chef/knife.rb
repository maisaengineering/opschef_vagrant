log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/Users/imaginationcoder/dev/projects/kids_link/automation/opsvagrant/chef-repo/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '/Users/imaginationcoder/dev/projects/kids_link/automation/opsvagrant/chef-repo/.chef/chef-validator.pem'
validation_key_path      '/Users/imaginationcoder/dev/projects/kids_link/automation/opsvagrant/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://192.168.50.101'
# syntax_check_cache_path  '/Users/imaginationcoder/dev/projects/kids_link/automation/opsvagrant/chef-repo/.chef/syntax_check_cache'
cookbook_path ["cookbooks", "site-cookbooks"]
knife["nodename"] = "chef_server"