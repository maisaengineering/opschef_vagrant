# include_recipe "mongodb::10gen_repo"

# recipe[mongodb::10gen_repo]

# mongodb_instance "mongodb" do
#   port node['application']['port']
# end

######***######***######***######***######***######
### GROUP & USER MANAGEMENT
######***######***######***######***######***######
klwebgrp = node[:webapp][:groups][:kldsgrp]
klwebber = node[:webapp][:users][:kldser]
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


#include_recipe "mongodb::default"
# execute "Import the public key used by the package management system." do
#   user kldser[:name]
#   command "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
# end
