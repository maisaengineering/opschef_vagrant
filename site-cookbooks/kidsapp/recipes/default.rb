#
# Cookbook Name:: site-cookbooks/kidsapp
# Recipe:: default
#
# Copyright (C) 2014 Chandan Benjaram
#
# All rights reserved - Do Not Redistribute
#

# ruby_block "CB Echo..." do
#     # These variables will now have the new values
#     puts node['etc']['passwd']['vagrant']['uid']
#     puts node['etc']['passwd']['vagrant']['gid']
#     puts node.to_yaml
#     # puts ":groups..." + node['common'].to_s
#     # puts ":users..." + node['webapp'].to_s
#     # puts ":users..." + node['matching_node'].to_s
# end
include_recipe 'git'

kidsapp_db = data_bag_item('keys', 'kidsapp')

puts "CB Echo..."
puts kidsapp_db.keys
puts "...done"


######***######***######***######***######***######
### GROUP & USER MANAGEMENT
######***######***######***######***######***######
klwebgrp = node[:webapp][:groups][:klwebgrp]
klwebber = node[:webapp][:users][:klwebber]
klwebber_home = "/home/#{klwebber[:name]}"

group klwebgrp[:name] do
  gid klwebgrp[:gid]
  append  true
end

user klwebber[:name] do
  supports :manage_home => true
  gid klwebgrp[:gid]
  uid klwebber[:uid]
  home klwebber_home
  shell "/bin/bash"
  password klwebber[:password]
  comment klwebber[:comment]
end

### Reload OHAI per http://docs.opscode.com/resource_user.html
ohai "reload" do
  action :reload
end

gem_package 'rake' do
  action :install
  version '10.3.1'
  options('--force')
end

######***######***######***######***######***######
### WEB APP CONFIGURATION
######***######***######***######***######***######
directory "#{klwebber_home}/.ssh" do
  owner klwebber[:name]
  group klwebgrp[:name]

  mode 0740
  action :create
end

# generate sshkey --- avoid password prompt caused by deploy_key way
execute "Generates ssh skys for #{klwebber[:name]}." do
  user klwebber[:name]
  creates "#{klwebber_home}/.ssh/kidsapp"
  command "ssh-keygen -t rsa -q -f #{klwebber_home}/.ssh/kidsapp -P \"\" -C ''"
end

# add key to GH
deploy_key "kidsapp" do
  owner klwebber[:name]
  group klwebgrp[:name]

  provider Chef::Provider::DeployKeyGithub
  path "#{klwebber_home}/.ssh"
  credentials({
    :token => kidsapp_db["gittoken"]
  })
  repo 'maisaengineering/kidslink'
  mode 0740

  action :add
end


deploy_wrapper 'kidsapp' do
  owner klwebber[:name]
  group klwebgrp[:name]

  ssh_wrapper_dir "#{klwebber_home}/.ssh"
  ssh_key_dir "#{klwebber_home}/.ssh"
  ssh_key_file "#{klwebber_home}/.ssh/kidsapp"
  sloppy true
end

# rvm_shell "passenger_module" do
#   ruby_string "ruby-2.0.0-p451"
#   code        "passenger-install-apache2-module --auto"
#   creates node[:passenger][:module_path]
# end

application 'kidsapp' do
  owner klwebber[:name]
  group klwebgrp[:name]

  path  '/var/www/html/kidsapp'
  scm_provider  Chef::Provider::Git
  repository kidsapp_db["ghwebapprepo"]

  environment_name  'development'
  revision  'dev'
  # restart_command 'touch /tmp/rails'

  # Apply the rails LWRP from application_ruby
  rails do
    environment ({'RAILS_ENV' => 'development'})
    # Rails-specific configuration. See the README in the
    # application_ruby cookbook for more information.
    # bundler true
    # restart_command 'touch /tmp/rails'
    # database_master_role "kidsapp_database_master"

    database do
      adapter "mongoid"
      host "dharma.mongohq.com:10041"
      database "app15437481"
      username "CBCHEF"
      password "123456"
      encoding utf8
      reconnect true
    end

  end
  #
  #
  # # # Apply the passenger_apache2 LWRP, also from application_ruby
  # passenger_apache2 do
  #   # Passenger-specific configuration.
  #   application  "kidsapp"
  #   server_aliases  [node[:hostname], "kidsapp"]
  #   webapp_template  "kidsapp.conf.erb"
  #   params  ({
  #     server_name: node[:fqdn],
  #     docroot: "/var/www/html/kidsapp/current/public",
  #     rails_env: "development"
  #   })
  # end

end

deploy_revision 'kidsapp' do
  keep_releases 2
  git_ssh_wrapper "#{klwebber_home}/.ssh/kidsapp_deploy_wrapper.sh"
  repository kidsapp_db["ghwebapprepo"]
end
