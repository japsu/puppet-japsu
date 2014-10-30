class postgresql(
    $postgresql_version = '9.3'
) {
    package {
        [
            'postgresql',
            'libpq-dev'
        ]:
            ensure => present;
    }

    file {
        "/etc/postgresql/$postgresql_version/main/pg_hba.conf":
          require => Package['postgresql'],
          ensure => present,
          source => ["puppet:///modules/postgresql/pg_hba.conf@${::hostname}",
                     'puppet:///modules/postgresql/pg_hba.conf'],
          notify => Service['postgresql'];            
    }
}
