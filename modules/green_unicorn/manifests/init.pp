class green_unicorn {
    define django(
        $app_root,
        $user='www-data',
        $listen='127.0.0.1:3000',
        $gunicorn='/usr/bin/gunicorn_django',
        $workers=4
    ) {
        file {
            "/etc/default/gunicorn_django-$title.conf":
                notify => Service['gunicorn_django'],
                ensure => present,
                content => template('green_unicorn/project_settings.erb');
        }
    }

    package {
        'lsb-base':
            ensure => present;
    }

    file {
        '/etc/init.d/gunicorn_django':
            ensure => present,
            mode => 0755,
            source => ["puppet:///modules/green_unicorn/init_script.sh@$::hostname",
                       'puppet:///modules/green_unicorn/init_script.sh'];
        '/etc/default/gunicorn_django':
            ensure => present,
            mode => 0644,
            source => ["puppet:///modules/green_unicorn/default_settings@$::hostname",
                       'puppet:///modules/green_unicorn/default_settings'];
    }

    service {
        'gunicorn_django':
            ensure => running,
            enable => true,
            hasstatus => false,
            hasrestart => true;
    }
}