class memcached {
    package {
        'memcached':
            ensure => present;
    }

    service {
        'memcached':
            require => Package['memcached'],
            ensure => running,
            enable => true,
            hasrestart => true,
            hasstatus => true;
    }
}