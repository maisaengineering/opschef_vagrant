site :opscode

cookbook 'sudo'


cookbook 'ruby_build'
cookbook 'rbenv', :github => 'fnichol/chef-rbenv.git', :tag => 'v0.7.2'
# cookbook 'rbenv', :git => 'git@github.com:fnichol/chef-rbenv.git'

cookbook 'chef-deploy_wrapper', git: 'git@github.com:cwjohnston/chef-deploy_wrapper.git'
cookbook 'chef-server', git: 'git://github.com/opscode-cookbooks/chef-server.git'

cookbook "application", "~> 4.1.4"
cookbook "application_ruby", git: "git@github.com:poise/application_ruby.git", ref: "f073ae50a58db1a0d496290888da457ee63244c8"
cookbook "mongodb", '>= 0.16.0', git: "git@github.com:edelight/chef-mongodb.git"

cookbook "nginx", git: "git@github.com:maisaengineering/nginx.git",ref: "fa97b30cc0ec7fff27fa9f0fa034a80897dab3ff"

cookbook 'kidsapp', '0.0.1', path: 'site-cookbooks/kidsapp'

cookbook 'deploy_key', :git => 'git@github.com:cassianoleal/cookbook-deploy_key.git', :branch => '0.1.0'
