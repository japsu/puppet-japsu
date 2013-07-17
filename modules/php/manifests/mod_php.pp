class php::mod_php {
  package {
    'libapache2-mod-php5':
      ensure => present;
  }

  exec {
    "a2enmod php5":
      require => Package['libapache2-mod-php5'],
      command => "/usr/sbin/a2enmod php5",
      creates => "/etc/apache2/mods-enabled/php5.load",
      notify => Service['apache2'];
    }
}