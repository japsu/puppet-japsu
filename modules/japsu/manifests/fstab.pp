class japsu::fstab {
  file {
    '/etc/fstab':
      ensure => present,
      source => "puppet:///modules/japsu/fstab@${::hostname}";
  }
}