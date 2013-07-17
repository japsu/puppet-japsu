class php::fpm {
  package { 'php5-fpm':
    ensure => installed,
  }
}