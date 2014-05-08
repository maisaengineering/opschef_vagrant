name             'kidsapp'
maintainer       'Chandan Benjaram'
maintainer_email 'labs@maisasolutions.com'
license          'All rights reserved'
description      'Installs/Configures site-cookbooks/kidsapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'apt'
depends 'git'
depends 'sudo'
depends 'build-essential'
depends 'ruby_build'
depends 'rbenv', "~> 0.7.2"
depends 'nginx'
depends 'chef-server'

depends 'deploy_key'
depends 'deploy_wrapper'

# depends 'application'
# depends 'application_ruby'
depends 'java'
