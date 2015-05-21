name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache v2.0'
description 'Installs/Configures Consul client, server and UI.'
long_description 'Installs/Configures Consul client, server and UI.'
version '1.0.0'

recipe 'consul', 'Installs and starts consul service.'
recipe 'consul::ui', 'Installs consul ui service.'

supports 'centos', '>= 6.5'
supports 'redhat', '>= 6.5'
supports 'ubuntu', '= 12.04'
supports 'ubuntu', '= 14.04'
supports 'arch'

depends 'libartifact'
depends 'golang', '~> 1.4'
depends 'poise', '~> 2.0'
depends 'runit'
