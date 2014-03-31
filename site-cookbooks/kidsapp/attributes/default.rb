# default.merge!(Hash.try_convert({
#   :webapp => {
#     :groups => {
#       :klwebgrp => {
#         :name => "klwebgrp",
#         :gid => 9786
#       }
#     },
#     :users => {
#       :klwebber => { 
#         :name => "klwebber",
#         :password => "$1$Y3UvR60B$O7gtZABr7KlHYpnLBioZn1", 
#         :comment => "A web user", 
#         :uid => 9001, 
#         :group => "klwebgrp"
#       }
#     } 
#   }
# }))

default[:webapp][:groups][:klwebgrp]={ :name => "klwebgrp", :gid => 9786 }
default[:webapp][:users][:klwebber]={ :name => "klwebber", :uid => 9001, :password => "$1$Y3UvR60B$O7gtZABr7KlHYpnLBioZn1",  :comment => "A web user", :group => "klwebgrp"}