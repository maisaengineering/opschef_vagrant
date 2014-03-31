#
# Cookbook Name:: kidsapp
# Recipe:: default
#
# Copyright (C) 2014 Chandan Benjaram
# 
# All rights reserved - Do Not Redistribute
#


# install apache
package "apache2" do
  action :install  
end


# start service (incl. boot enabled)
service "apache2" do
  action %w(start enable)
end


cookbook_file "/var/www/index.html" do
  source "index.html"
  mode "0644"
  # owner "root"
  # group "root"
end
  