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
      "users" => ["vagrant", "root", "klwebber", "nginxer"]
    }
}

node.override['vagrant'] = {
    "system_chef_solo" => "/opt/vagrant_ruby/bin/chef-solo"
}



# # nginx
# node.override['nginx']['user'] = "nginxer"
# node.override['nginx']['group'] = "root"
#
#
#
# ### COPY
# node.override['nginx']['version']= '1.4.5'
# node.override['nginx']['dir']= '/etc/nginx'
# node.override['nginx']['log_dir']= '/var/log/nginx'
# node.override['nginx']['binary']= "/opt/nginx-#{node['nginx']['version']}/sbin"
# node.override['nginx']['init_style']= 'init'
# node.override['nginx']['default_site_enabled']= false
#
#
# node.override['nginx']['source']['sbin_path']= "#{node['nginx']['binary']}/nginx"
# node.override['nginx']['source']['version']= node['nginx']['version']
# node.override['nginx']['source']['modules']= ["nginx::http_stub_status_module", "nginx::http_ssl_module", "nginx::http_gzip_static_module", "nginx::passenger"]
# node.override['nginx']['source']['prefix'] = "/opt/nginx-#{node['nginx']['source']['version']}"
# node.override['nginx']['source']['default_configure_flags'] = ["--prefix=#{node['nginx']['source']['prefix']}","--conf-path=#{node['nginx']['dir']}/nginx.conf", "--sbin-path=#{node['nginx']['source']['sbin_path']}"]
# node.override['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
# #
# # # passenger
# node.override['nginx']['passenger']['version'] = '4.0.37'
# node.override['nginx']['passenger']['ruby'] = "/usr/local/rbenv/shims/ruby"
# node.override['nginx']['passenger']['gem_binary'] = "/usr/local/rbenv/versions/2.0.0-p451/bin/gem"
# node.override['nginx']['passenger']['root'] = "/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.37"
# node.override['nginx']['configure_flags'] = ["--add-module=/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41/ext/nginx"]
#
# node.override['runit']['service_dir'] = "#{node['nginx']['binary']"
#
#


node.override['java'] = {
    "install_flavor" => "oracle",
    "jdk_version" => "6",
    "oracle" => {
      "accept_oracle_download_terms" => true
    }
}

node.override['nginx'] = {
    "version" => "1.4.5",
    "dir" => "/etc/nginx",
    "log_dir" => "/var/log/nginx",
    "user" => "klwebber",
    "group" => "klwegrp",
    "use_existing_user" => true,

    "binary" => "/opt/nginx-1.4.5/sbin",
    "init_style" => "init",
    "prefix" => false,

    "source" => {
        "sbin_path" => "/opt/nginx-1.4.5/sbin/nginx",
        "version" => "1.4.5",
        "prefix" => "/opt/nginx-1.4.5",

        "user" => "klwebber",
        "group" => "root",
        "use_existing_user" => true,


        "modules" => [
            "nginx::http_stub_status_module",
            "nginx::http_ssl_module",
            "nginx::http_gzip_static_module",
            "nginx::passenger"
        ],
        "default_configure_flags" => [
            "--prefix=/opt/nginx-1.4.5","--conf-path=/etc/nginx/nginx.conf", "--sbin-path=/opt/nginx-1.4.5/sbin/nginx"
        ],

        "url" => "http://nginx.org/download/nginx-1.4.5.tar.gz"
    },
    "passenger" => {
        "version" => "4.0.41",
        "ruby" => "/usr/local/rbenv/shims/ruby",
        "gem_binary" => "/usr/local/rbenv/versions/2.0.0-p451/bin/gem",
        "root" => "/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41",
        "gems" => []
    },
    "configure_flags" => [
      "--add-module=/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41/ext/nginx"
    ]
}
