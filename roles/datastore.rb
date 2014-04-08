name "datastore"
description "Database stack (MongoDB)"
run_list %w(recipe[kidsapp::vm_commons] recipe[sudo] recipe[mongodb::10gen_repo] recipe[mongodb::default@0.16.0] recipe[kidsapp::datastore_mongo])
default_attributes({
  # "mongodb" => {
  #   "package_version" => "0.6"
  # },
  "authorization" => {
    "sudo" => {
      "groups" => ["vagrant", "root", "admin", "wheel", "kldsgrp"],
      "users" => ["vagrant", "root", "kldser"]
    }
  },
  "datastore" => {
    "port" => 28017
  }

  })
# default_attributes({
#   "mongodb" => {
#
#     "config" => [
#       # { 'dbpath'    => 'bundler' },
#       # { 'name'    => 'rake' },
#       # { 'name' => 'chef'}
#     ]
#   },
#   "authorization" => {
#     "sudo" => {
#       "groups" => ["vagrant", "root", "admin", "wheel", "kldbgrp"],
#       "users" => ["vagrant", "root", "kldber"]
#     }
#   }
# })
