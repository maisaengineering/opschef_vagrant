#
# Cookbook Name:: kidsapp
# Recipe:: default
#
# Copyright (C) 2014 Chandan Benjaram
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

kidsapp_db = data_bag_item('keys', 'kidsapp')


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

### CREATE/ADD APP USER TO APP GROUP
user klwebber[:name] do
  supports :manage_home => true
  gid klwebgrp[:gid]
  uid klwebber[:uid]
  home klwebber_home
  shell "/bin/bash"
  password klwebber[:password]
  comment klwebber[:comment]
end


gem_package 'rake' do
  action :install
  version '10.1.1'
  options('--force')
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

application 'kidsapp' do
  owner klwebber[:name]
  group klwebgrp[:name]
  path  '/var/www/html/kidsapp'

  scm_provider  Chef::Provider::Git
  repository kidsapp_db["ghwebapprepo"]
  revision  'dev'

  # restart_command 'touch /tmp/rails'
  migrate  true

  environment ({
    "RAILS_ENV"=>"staging"
  })

  # Apply the rails LWRP from application_ruby
  rails do
    bundler true
    bundler_deployment true
    bundle_options "2>&1 | tee -a /tmp/bundler.log"
    restart_command 'touch /tmp/rails'

environment ({
  "RAILS_ENV"=>"staging"
})

    # database_master_role "kidsapp_database_master"
    # database do
    #   adapter "mongoid"
    #   host "dharma.mongohq.com:10041"
    #   database "app15437481"
    #   username "CBCHEF"
    #   password "123456"
    #   encoding utf8
    #   reconnect true
    # end

  end

end

deploy_revision 'kidsapp' do
  keep_releases 2
  git_ssh_wrapper "#{klwebber_home}/.ssh/kidsapp_deploy_wrapper.sh"
  repository kidsapp_db["ghwebapprepo"]
end
