#
# Cookbook Name:: site-cookbooks/kidsapp
# Recipe:: default
#
# Copyright (C) 2014 Chandan Benjaram
# 
# All rights reserved - Do Not Redistribute
#
include_recipe 'git'

# include_recipe 'deploy_key::github'

# ruby_block "CB Echo..." do
#     # These variables will now have the new values
#     puts node['etc']['passwd']['vagrant']['uid']
#     puts node['etc']['passwd']['vagrant']['gid']
#     puts node.to_yaml
#     # puts ":groups..." + node['common'].to_s
#     # puts ":users..." + node['webapp'].to_s
#     # puts ":users..." + node['matching_node'].to_s
# end

puts "CB Echo..."
kidsapp_db = data_bag_item('keys', 'kidsapp')
puts kidsapp_db[:gittoken]
puts kidsapp_db["gittoken"]
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


######***######***######***######***######***######
### WEB APP CONFIGURATION
######***######***######***######***######***######
directory "#{klwebber_home}/.ssh" do
  owner klwebber[:name]
  group klwebgrp[:name]
  
  mode 00700
  action :create
end

execute "Generates ssh skys for #{klwebber[:name]}." do
  user klwebber[:name]
  creates "#{klwebber_home}/.ssh/kidsapp"
  command "ssh-keygen -t rsa -q -f #{klwebber_home}/.ssh/kidsapp -P \"\""
end

deploy_key "kidsapp" do
  owner klwebber[:name]
  group klwebgrp[:name]
  
  provider Chef::Provider::DeployKeyGithub
  path "#{klwebber_home}/.ssh"
  credentials({
    :token => kidsapp_db[:gittoken]
    # :token => '440f77d5dbfcdea370811ac88f1851eddc880e38'
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

application 'kidsapp' do
  owner klwebber[:name]
  group klwebgrp[:name]
  
  path  '/var/www/html/kidsapp'
  scm_provider  Chef::Provider::Git
  repository 'git@github.com:maisaengineering/kidslink.git'
  
  environment_name  'development'
  revision   'dev'


  # Apply the rails LWRP from application_ruby
  rails do
    environment ({'RAIL_ENV' => 'development'})
    # Rails-specific configuration. See the README in the
    # application_ruby cookbook for more information.
  end

  # # Apply the passenger_apache2 LWRP, also from application_ruby
  # passenger_apache2 do
  #   # Passenger-specific configuration.
  # end

end

deploy_revision 'kidsapp' do
  git_ssh_wrapper "#{klwebber_home}/.ssh/kidsapp_deploy_wrapper.sh"
  repository 'git@github.com:maisaengineering/kidslink.git'  
end