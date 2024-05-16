# Increases the amount of traffic a Nginx server can handle.

# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  # Modify the ULIMIT value
  command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
  # Specify the path for the sed command
  path    => '/usr/local/bin/:/bin/',
}

# Restart Nginx using SysV init
service { 'nginx':
  ensure   => 'running',
  enable   => true,
  provider => init,
  require  => Exec['fix--for-nginx'],
}
