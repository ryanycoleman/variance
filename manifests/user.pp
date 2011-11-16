# Actions: Creates a user, group and home directory. Users shell value comes from the fqdn_function to introduce variance.  
#
# Parameters:
#
define variance::user {

  $usershell = fqdn_rand(3)

  user { $name:
    ensure     => present,
    home       => "/home/${name}",
    managehome => true,
    shell      => $usershell ? {
      '0' => '/bin/bash',
      '1' => '/bin/ksh',
      '2' => '/bin/nologin',
    }
  }

  if ! defined ( Group[$name] ) {
    group { $name:
      ensure  => $ensure,
      before => User[$name],
    }
  }
  
  $random_number = fqdn_rand(3000,30)
  file { "/home/$name/hello.txt":
    ensure => file,
    content => "There are ${random_number} reasons to love Puppet!\n",
    require => User[$name],
  }

}
