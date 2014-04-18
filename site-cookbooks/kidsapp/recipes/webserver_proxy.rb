#
# Cookbook Name:: site-cookbooks/kidsapp
# Recipe:: webserver_proxy
#
# Copyright (C) 2014 Chandan Benjaram
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'kidsapp::vm_commons'
include_recipe 'git::default'
include_recipe 'sudo'
include_recipe 'build-essential::default'
include_recipe 'ruby_build'

include_recipe 'rbenv::system'
include_recipe 'rbenv::vagrant'
include_recipe 'apt::default'

include_recipe 'nginx::source'
include_recipe 'kidsapp::default'



puts "CB spitting..."
# node.each  do |k, v|
#   puts "key...#{k}, value...#{v}"
# end
