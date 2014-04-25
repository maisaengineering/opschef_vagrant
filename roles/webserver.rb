name "webserver"
description "Rails stack"
run_list %w(recipe[kidsapp::webserver_proxy])
