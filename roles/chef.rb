name "chef"
# chef_type  "role"
# json_class  "Chef::Role"
description "The base role for Chef Server"
run_list %w(recipe[kidsapp::vm_commons] recipe[chef-server::default])
default_attributes(
  "chef-server" => {
   "version" => "latest",
   "configuration" => {
     "chef_server_webui" => {
       "enable" => true
     }
   }
  }
)
