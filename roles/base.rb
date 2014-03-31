name "base"
description "Baseline configuration for all systems."
default_attributes(
  "company" => "Maisa Solutions",
  # "chef-client" => {
  #   "server_url" => "https://api.opscode.com/organizations/ORGNAME",
  #   "validation_client_name" => "chef-validator"
  # },
  # "groups" => {
#     "admins" => {"gid" => 786},
#   },
#   "users" => {
#     :kladmin => { :password => "*", :comment => "KL Admin User", :uid => 1001, :group => :admins },
#     :mpride => { :password => "*", :comment => "M Pride Support", :uid => 1002, :group => :admins },
#   },
#   
  "common" => {
    "groups" => {
      "admin" => {"gid" => 786},
    },
    "users" => {
      "mpride" => { "password" => "*", "comment" => "M Pride Support", "uid" => 1002, "group" => "admin" },
    } 
  },
  "webapp" => {
    "groups" => {
      "klwebgrp" => { "gid" => 1786},
    },
    "users" => {
      "kladmin" => { "password" => "*", "comment" => "KL Admin User", "uid" => 1001, "group" => "admin" }
    } 
  }
)
# 
# 
# name "base"
# description "Baseline configuration for all systems."
#  
# run_list(
#   "recipe[ohai]",
#   "recipe[chef-client::delete_validation]",
#   "recipe[chef-client]",
#   "recipe[zsh]",
#   "recipe[git]",
#   "recipe[users]",
#   "recipe[vim]",
#   "recipe[sudo]",
#   "recipe[ntp]",
#   "recipe[resolver]",
#   "recipe[lvm]",
#   "recipe[build-essential]",
#   "recipe[ruby]",
#   "recipe[rsyslog::client]",
#   "recipe[logwatch]",
#   "recipe[logrotate]",
#   "recipe[tmux]",
#   "recipe[man]",
#   "recipe[openssh]",
#   "recipe[rsync]",
#   "recipe[postfix]",
#   "recipe[munin::client]"
# )
#  
# default_attributes(
#   "chef-client" => {
#     "server_url" => "https://api.opscode.com/organizations/ORGNAME",
#     "validation_client_name" => "chef-validator"
#   },
#   "authorization" => {
#     "sudo" => {
#       "groups" => ["admin", "wheel"],
#       "users" => ["myusername"]
#     }
#   }
# 
# )