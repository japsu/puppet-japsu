class virtualbox::guest {
  package {
    [
      'virtualbox-guest-utils',
      'virtualbox-guest-dkms',
      'virtualbox-guest-source'
    ]:
      ensure => present;
  }

  exec {
    'update-initramfs':
      command => '/usr/sbin/update-initramfs -u -k all',
      refreshonly => true;
  }

  file {
    # disable modules that are useless in a virtual environment
    '/etc/modprobe.d/virtualbox-blacklist.conf':
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => 0644,
      source => 'puppet:///modules/virtualbox/module-blacklist.conf',
      notify => Exec['update-initramfs'];
  }
}