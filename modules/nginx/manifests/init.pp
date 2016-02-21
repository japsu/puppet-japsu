class nginx {
    define site () {
        file {
            "/etc/nginx/sites-available/$title":
                notify => Service['nginx'],
                ensure => present,
                source => ["puppet:///modules/nginx/$title.conf@$hostname",
                           "puppet:///modules/nginx/$title.conf"];
            "/etc/nginx/sites-enabled/$title":
                notify => Service['nginx'],
                ensure => link,
                target => "/etc/nginx/sites-available/$title";
        }
    }

    define proxy (
        $target,
        $template='nginx/proxy.conf.erb',
        $server_name=$title,
        $static_path=undef,
        $media_path=undef,
        $letsencrypt=false,
        $ssl=false,
        $ssl_certificate=undef,
        $ssl_certificate_key=undef,
        $ssl_strict_transport_security=false,
        $enforce_sso=false,
    ) {
        file {
            "/etc/nginx/sites-available/$title":
                notify => Service['nginx'],
                ensure => present,
                content => template($template);
            "/etc/nginx/sites-enabled/$title":
                notify => Service['nginx'],
                ensure => link,
                target => "/etc/nginx/sites-available/$title";
        }
    }

    define php ($app_root) {
        file {
            "/etc/nginx/sites-available/$title":
                notify => Service['nginx'],
                ensure => present,
                content => template('nginx/php.conf.erb');
            "/etc/nginx/sites-enabled/$title":
                notify => Service['nginx'],
                ensure => link,
                target => "/etc/nginx/sites-available/$title";
        }
    }

    define redirect ($target) {
        file {
            "/etc/nginx/sites-available/$title":
                notify => Service['nginx'],
                ensure => present,
                content => template('nginx/redirect.conf.erb');
            "/etc/nginx/sites-enabled/$title":
                notify => Service['nginx'],
                ensure => link,
                target => "/etc/nginx/sites-available/$title";
        }
    }

    apt::source {
        'nginx':
            location => $operatingsystem ? {
                'Debian' => 'http://nginx.org/packages/debian/',
                'Ubuntu' => 'http://nginx.org/packages/ubuntu/'
            },
            repos => 'nginx',
            key => $operatingsystem? {
                'Debian' => 'A524C53E',
                'Ubuntu' => '7BD9BF62'
            },
            key_server => 'keyserver.ubuntu.com',
            include_src => false;
    }

    package {
        'nginx':
            require => Apt::Source['nginx'],
            ensure => present;
    }

    service {
        'nginx':
            ensure => running,
            enable => true,
            hasstatus => true,
            hasrestart => true;
    }

    user {
        'www-data':
            ensure => present
    }

    file {
        '/etc/nginx':
            ensure => directory;
        '/etc/nginx/sites-available':
            ensure => directory;
        '/etc/nginx/sites-enabled':
            ensure => directory;
        '/etc/nginx/nginx.conf':
            notify => Service['nginx'],
            ensure => present,
            source => ["puppet:///modules/nginx/nginx.conf@$hostname",
                       'puppet:///modules/nginx/nginx.conf'];
        '/etc/nginx/fastcgi_params':
            notify => Service['nginx'],
            ensure => present,
            source => 'puppet:///modules/nginx/fastcgi_params';
        '/var/www':
            ensure => directory,
            mode => 0755;
        '/var/www/index.html':
            ensure => present,
            content => template('nginx/index.html.erb'),
            mode => 0644;
    }

    nginx::site {
        'default':
    }
}
