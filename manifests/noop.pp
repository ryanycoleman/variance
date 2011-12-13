class variance::noop inherits variance {

  File['/etc/motd'] {
    noop => true,
  }

}
