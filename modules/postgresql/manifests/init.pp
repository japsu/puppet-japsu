class postgresql {
    package {
        [
            'postgresql',
            'libpq-dev'
        ]:
            ensure => present;
    }
}
