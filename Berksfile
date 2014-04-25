site :opscode

cookbook 'sudo'
cookbook 'ruby_build'
cookbook 'rbenv', :git => 'git@github.com:fnichol/chef-rbenv.git', :ref => "0a3018634bafe58ad21c6ee271af015220e444b9"
# cookbook 'rbenv', :git => 'git@github.com:fnichol/chef-rbenv.git'

cookbook 'chef-deploy_wrapper', git: 'git@github.com:cwjohnston/chef-deploy_wrapper.git'
cookbook 'chef-server', git: 'git://github.com/opscode-cookbooks/chef-server.git'

cookbook "application", "~> 4.1.4"
cookbook "application_ruby", git: "git@github.com:poise/application_ruby.git", ref: "fde770d176b5d0519982e2ec93bcf2d1a3ad35bb"
cookbook "mongodb", '>= 0.16.0', git: "git@github.com:edelight/chef-mongodb.git"
cookbook "nginx", git: "git@github.com:maisaengineering/nginx.git",ref: "0b5ca18342470da8c45289bf26c92651791ebde1"
cookbook 'deploy_key', :git => 'git@github.com:cassianoleal/cookbook-deploy_key.git', :branch => '0.1.0'
cookbook 'java'

cookbook 'kidsapp', '0.0.1', path: 'site-cookbooks/kidsapp'
