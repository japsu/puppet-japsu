class php::mod_php {
  include apache

  package {
    'libapache2-mod-php5':
      ensure => present;
  }

  file {
    '/etc/php5/apache2/php.ini':
      require => Package['libapache2-mod-php5'],
      ensure => present,
      source => ["puppet:///modules/php/php.ini@${::hostname}",
                 'puppet:///modules/php/php.ini'],
      notify => Service['apache2'];
  }

  apache::module {
    'php5':
      require => Package['libapache2-mod-php5']
  }
}