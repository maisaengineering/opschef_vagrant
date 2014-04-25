#
# Cookbook Name:: site-cookbooks/kidsapp
# Recipe:: webserver_proxy
#
# Copyright (C) 2014 Chandan Benjaram
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'kidsapp::vm_commons'
include_recipe 'apt::default'
include_recipe 'build-essential::default'
include_recipe 'java'

include_recipe 'git::default'
include_recipe 'sudo'

include_recipe 'ruby_build::default'
include_recipe 'rbenv::system'
include_recipe 'rbenv::vagrant'

include_recipe 'kidsapp::railsapp'

include_recipe 'nginx::source'

template "#{node["nginx"]["dir"]}/conf.d/passenger.conf" do
  source 'passenger.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end
