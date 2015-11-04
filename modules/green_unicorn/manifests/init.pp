class green_unicorn {
    define instance(
        $app_root,
        $wsgi_app,
        $gunicorn,
        $user='www-data',
        $listen='127.0.0.1:3000',
        $workers=4,
    ) {
        file {
            "/etc/init/$title.conf":
                notify => Service[$title],
                ensure => present,
                content => template('green_unicorn/upstart.erb');
        }

        service {
            $title:
                provider => 'upstart',
                ensure => running,
                enable => true;
        }
    }
}
