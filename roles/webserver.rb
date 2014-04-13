name "webserver"
description "Rails stack"
run_list %w(recipe[kidsapp::vm_commons] recipe[sudo] recipe[build-essential] recipe[ruby_build] recipe[rbenv::system] recipe[rbenv::vagrant]
recipe[apt::default] recipe[nginx::source] recipe[kidsapp::default])
default_attributes({
  "rbenv" => {
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
  },
  "authorization" => {
    "sudo" => {
      "groups" => ["vagrant", "root", "admin", "wheel", "klwebgrp"],
      "users" => ["vagrant", "root", "klwebber"]
    }
  },
  "rails"  => {
    "max_pool_size" => 5
  },
  "vagrant" => {
    "system_chef_solo" => "/opt/vagrant_ruby/bin/chef-solo"
  },

  "nginx"  => {
    "version" => "1.4.0",
    "dir" => "/etc/nginx",
    "log_dir" => "/var/log/nginx",
    "user" => "nginxer",
    "group" => "root",
    "binary" => "/opt/nginx-2.6.2/sbin",
    "use_existing_user" => true,

    "install_method"  => "package",
    "repo_source"  => "nginx",

    # "init_style" => "init",
    "source" => {
        "modules" => [
            "nginx::http_stub_status_module",
            "nginx::http_ssl_module",
            "nginx::http_gzip_static_module",
            "nginx::passenger",
            ]
        },
    "passenger" => {
        "version" => "4.0.14",
        "ruby" => "/usr/local/rbenv/shims/ruby",
        "root" => "/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41"
    },
    "configure_flags" => [
      "--add-module=/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41/ext/nginx"
    ]
  }
  # "passenger"  => {
  #   "ruby_bin" => "/usr/local/rvm/rubies/ruby-2.0.0-p451/bin/ruby"
  # }
})

# name "webserver"
# description "Rails stack"
# run_list %w(recipe[kidsapp::vm_commons]  recipe[rvm::system] recipe[rvm::vagrant] recipe[kidsapp::default])
# default_attributes={
#   "company" => "Maisa Solutions",
#   :groups => {
#   :klwebgrp => {:gid => 9001},
#   },
#   :users => {
#   :klwebber => { :password => "*", :comment => "A Web User", :uid => 9051, :group => :klwebgrp },
#   },
#
#   "rvm" => {
#     "rubies" => ["ruby-2.0.0-p451"],
#     "default_ruby" => "ruby-2.0.0-p451",
#     "global_gems" => [
#       { 'name'    => 'bundler' },
#       { 'name'    => 'rake' }
#     ]
#   }
# }
