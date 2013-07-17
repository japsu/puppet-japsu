class mysql {
  package {
    [
      'mysql-server',
      'libmysqlclient-dev'
    ]:
      ensure => present;
  }
}