name             'kidsapp'
maintainer       'Chandan Benjaram'
maintainer_email 'labs@maisasolutions.com'
license          'All rights reserved'
description      'Installs/Configures site-cookbooks/kidsapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'


depends 'git'
depends 'deploy_key'
depends 'deploy_wrapper'
depends 'sudo'
depends 'application'
depends 'application_ruby'
depends 'nginx'
#depends 'http_stub_status_module'
# depends 'rails'
# depends 'passenger_apache2'

# depends "mongodb"
# depends 'yum', '>= 3.0'
