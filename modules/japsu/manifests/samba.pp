class japsu::samba {
  package {
    'samba':
      ensure => present;
  }

  file {
    '/etc/samba/smb.conf':
      require => Package['samba'],
      notify => Service['smbd'],
      ensure => present,
      source => "puppet:///modules/japsu/smb.conf@${::hostname}";
  }

  service {
    'smbd':
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true;
  }
}