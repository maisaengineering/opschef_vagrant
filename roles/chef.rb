name "chef"
# chef_type  "role"
# json_class  "Chef::Role"
description "The base role for Chef Server"
run_list %w(recipe[kidsapp::vm_commons] recipe[rvm::system] recipe[chef-server::default])
default_attributes(
  "rvm" => {
    "rubies" => ["ruby-2.0.0-p451"],
    "default_ruby" => "ruby-2.0.0-p451",
    "global_gems" => [
      { 'name'    => 'bundler' },
      { 'name'    => 'rake' },
      { 'name' => 'chef'}
    ]
  },
  "chef-server" => {
   "version" => "latest",
   "configuration" => {
     "chef_server_webui" => {
       "enable" => true
     }
   }
  }
)
