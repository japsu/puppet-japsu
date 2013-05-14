class virtualbox::guest {
  package {
    [
      'virtualbox-guest-utils',
      'virtualbox-guest-dkms',
      'virtualbox-guest-source',
      'linux-headers-amd64'
    ]:
      ensure => present;
  }
}