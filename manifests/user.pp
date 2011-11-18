# Define: variance::user
#
# Introduce random changes to some nodes to demonstrate variance in PE Console
#
# Actions: Creates a user, group and home directory. Users shell value comes from the fqdn_function to introduce variance.
#
define variance::user {

  $random_shell_choice = fqdn_rand(3)
  $random_number       = fqdn_rand(3000,30)

  $shell = $random_shell_choice ? {
    '0' => '/bin/bash',
    '1' => '/bin/ksh',
    '2' => '/bin/sh',
    '3' => '/bin/nologin',
  }

  user { $name:
    ensure     => present,
    home       => "/home/${name}",
    shell      => $shell,
  }

  if ! defined ( Group[$name] ) {
    group { $name:
      ensure => $ensure,
    }
  }

  File {
    owner => $name,
    group => $name,
    mode  => '0600',
  }
  file {"/home/${name}":
    ensure => directory,
  }
  file { "/home/${name}/hello.txt":
    ensure  => file,
    content => "There are ${random_number} reasons to love Puppet!\n",
  }

}
