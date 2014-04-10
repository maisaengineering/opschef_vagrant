name "webserver"
description "Rails stack"
run_list %w(recipe[kidsapp::vm_commons] recipe[rvm::system] recipe[sudo] recipe[rvm::vagrant] recipe[kidsapp::default])
default_attributes({
  "rvm" => {
    "rubies" => ["ruby-2.0.0-p451"],
    "default_ruby" => "ruby-2.0.0-p451",
    "global_gems" => [
      { 'name'    => 'bundler' },
      { 'name'    => 'rake' },
      { 'name' => 'chef'}
    ]
  },
  "authorization" => {
    "sudo" => {
      "groups" => ["vagrant", "root", "admin", "wheel", "klwebgrp"],
      "users" => ["vagrant", "root", "klwebber"]
    }
  },
  "rails"  => {
    "max_pool_size" => 5
  }
})

# name "webserver"
# description "Rails stack"
# run_list %w(recipe[kidsapp::vm_commons]  recipe[rvm::system] recipe[rvm::vagrant] recipe[kidsapp::default])
# default_attributes={
#   "company" => "Maisa Solutions",
#   :groups => {
#   :klwebgrp => {:gid => 9001},
#   },
#   :users => {
#   :klwebber => { :password => "*", :comment => "A Web User", :uid => 9051, :group => :klwebgrp },
#   },
#
#   "rvm" => {
#     "rubies" => ["ruby-2.0.0-p451"],
#     "default_ruby" => "ruby-2.0.0-p451",
#     "global_gems" => [
#       { 'name'    => 'bundler' },
#       { 'name'    => 'rake' }
#     ]
#   }
# }
