#
# Cookbook Name:: site-cookbooks/kidsapp
# Recipe:: default
#
# Copyright (C) 2014 Chandan Benjaram
#
# All rights reserved - Do Not Redistribute
#


# apt-get command
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end
