name             'haproxy'
maintainer       'moovel'
maintainer_email 'hello@moovel.com'
license          'MIT'
description      'Installs/Configures opsworks-haproxy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'amazon'
depends 'opsworks_commons' # haproxy undeclared dependency
depends 'haproxy'
depends 'opsworks-utils'
