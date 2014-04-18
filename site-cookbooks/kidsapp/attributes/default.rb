# default.merge!(Hash.try_convert({
#   :webapp => {
#     :groups => {
#       :klwebgrp => {
#         :name => "klwebgrp",
#         :gid => 9786
#       }
#     },
#     :users => {
#       :klwebber => {
#         :name => "klwebber",
#         :password => "$1$Y3UvR60B$O7gtZABr7KlHYpnLBioZn1",
#         :comment => "A web user",
#         :uid => 9001,
#         :group => "klwebgrp"
#       }
#     }
#   }
# }))

default[:webapp][:groups][:klwebgrp]={ :name => "klwebgrp", :gid => 9786 }
default[:webapp][:users][:klwebber]={ :name => "klwebber", :uid => 9001, :password => "$1$Y3UvR60B$O7gtZABr7KlHYpnLBioZn1",  :comment => "A web user", :group => "klwebgrp"}

node.override['rbenv']= {
  "rubies" => ["2.0.0-p451"],
  'global'  => '2.0.0-p451',
  'gems'    => {
    '2.0.0-p451'    => [
      { 'name'    => 'bundler'},
      { 'name'    => 'passenger'},
      # {"name" => "rails", "version" => "4.0.0" }
      # {'name'  => 'http_stub_status_module'}
    ]
  }
}

node.override['authorization'] = {
    "sudo" => {
      "groups" => ["vagrant", "root", "admin", "wheel", "klwebgrp"],
      "users" => ["vagrant", "root", "klwebber"]
    }
}

node.override['vagrant'] = {
    "system_chef_solo" => "/opt/vagrant_ruby/bin/chef-solo"
}


node.override['nginx'] = {
    "version" => "1.4.0",
    "dir" => "/etc/nginx",
    "log_dir" => "/var/log/nginx",
    "user" => "nginxer",
    "group" => "root",
    "binary" => "/opt/nginx-2.6.2/sbin",
    "use_existing_user" => true,

    "install_method"  => "package",
    "repo_source"  => "nginx",
    "default_site_enabled" => true,
    "default_root" => "/var/www/html/kidsapp/current/public/",
    "init_style" => "init",
    "source" => {
        "modules" => [
            "nginx::http_stub_status_module",
            "nginx::http_ssl_module",
            "nginx::http_gzip_static_module",
            "nginx::passenger"
            ]
        },
    "passenger" => {
        "version" => "4.0.41",
        "install_rake" => false,
        "ruby" => "/usr/local/rbenv/shims/ruby",
        "root" => "/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41",
        "www_dir" => "/var/www/html/kidsapp/current/public",
        "gems" => []
    },
    "configure_flags" => [
      "--add-module=/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41/ext/nginx"
    ]
}
