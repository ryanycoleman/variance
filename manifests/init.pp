class variance {

  $random_number = fqdn_rand(3000,30)

  File {
    owner => root,
    group => root,
    mode  => '0600',
  }
  file { "/etc/motd":
    ensure  => file,
    content => "There are ${variance::random_number} reasons to love Puppet!\n\nWelcome to ${::fqdn} which has ${::memoryfree} of free memory.\n",
  }

}
