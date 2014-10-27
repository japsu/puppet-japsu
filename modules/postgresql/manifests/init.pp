class postgresql {
    package {
        [
            'postgresql-server',
            'libpq-dev'
        ]:
            ensure => present;
    }
}
