default[:webapp][:groups][:klwebgrp]={ :name => "klwebgrp", :gid => 9786 }
default[:webapp][:users][:klwebber]={ :name => "klwebber", :uid => 9001, :password => "$1$Y3UvR60B$O7gtZABr7KlHYpnLBioZn1",  :comment => "A web user", :group => "klwebgrp"}

# node.override['rbenv']['rubies'] = [ "2.0.0-p451"]
# node.override['rbenv']['gems'] = {
#   '2.0.0-p451' => [
#     { 'name'    => 'passenger',
#       'version' => '4.0.41'
#     },
#     { 'name'    => 'bundler' }  ]
# }

node.override['kidsapp']['rackenv'] = "development"

node.override['rbenv']= {
  "rubies" => ["2.0.0-p451"],
  "global" => "2.0.0-p451",
  'gems'    => {
    '2.0.0-p451'    => [
      { 'name'    => 'passenger', 'version' => '4.0.41'},
      { 'name'    => 'bundler'}
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

node.override['java'] = {
    "install_flavor" => "oracle",
    "jdk_version" => "6",
    "oracle" => {
      "accept_oracle_download_terms" => true
    }
}

node.override['nginx'] = {
    "version" => "1.4.7",
    "init_style" => "runit",
    "source" => {
        # "conf_path" => "/opt/nginx.conf",
        "version" => "1.4.7",
        "user" => "nginxer",
        "use_existing_user" => true,
        "url" => "http://nginx.org/download/nginx-1.4.7.tar.gz",
        "sbin_path" => "/opt/nginx-1.4.7/sbin/nginx",
        "prefix" => "/opt/nginx-1.4.7",
        "modules" => [
            "nginx::http_stub_status_module",
            "nginx::http_ssl_module",
            "nginx::http_gzip_static_module",
            "nginx::passenger"
        ],
        "default_configure_flags" => %w( --prefix=/opt/nginx-1.4.7 --sbin-path=/opt/nginx-1.4.7/sbin/nginx)
    },
    "passenger" => {
        "version" => "4.0.41",
        "ruby" => "/usr/local/rbenv/shims/ruby",
        "gem_binary" => "/usr/local/rbenv/versions/2.0.0-p451/bin/gem",
        "root" => "/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41",
        "gems" => %w()
    },
    "configure_flags" => [
      "--add-module=/usr/local/rbenv/versions/2.0.0-p451/lib/ruby/gems/2.0.0/gems/passenger-4.0.41/ext/nginx"
    ]
}
