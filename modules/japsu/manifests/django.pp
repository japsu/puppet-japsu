class japsu::django {
    define instance(
        $listen,
        $source,
        $revision = 'master',
        $user = 'www-data',
        $server_name = $title,
        $project_root = "/srv/$title",
        $wsgi_app,
        $ssl = false,
        $ssl_certificate = undef,
        $ssl_certificate_key = undef,
        $ssl_strict_transport_security = false
    ) {
        $virtualenv = "$project_root/virtualenv"
        $app_root = "$project_root/app"

        group {
            $user:
                ensure => present;
        }

        user {
            $user:
                ensure => present,
                gid => $user,
                home => $project_root,
                managehome => true,
                shell => '/bin/bash';
                # groups => [ 'git' ];
        }

        vcsrepo {
            $app_root:
                require => User[$user],
                ensure => latest,
                notify => Service[$title],
                provider => git,
                source => $source,
                revision => $revision,
                user => $user,
                owner => $user,
                group => $user;
        }

#        python::virtualenv {
#            $virtualenv:
#                require => Vcsrepo[$app_root],
#                ensure => present,
#                version => 'system',
#                requirements => "$app_root/requirements.txt",
#                systempkgs => false,
#                distribute => false,
#                owner => $user,
#                group => $user;
#        }

        green_unicorn::instance {
            $title:
                # require => Python::Virtualenv[$virtualenv],
                gunicorn => "$virtualenv/bin/gunicorn",
                app_root => $app_root,
                wsgi_app => $wsgi_app,
                user => $user,
                listen => $listen;
        }

        nginx::proxy {
            $title:
                target => "http://$listen",
                static_path => "$app_root/static",
                ssl => $ssl,
                ssl_certificate => $ssl_certificate,
                ssl_certificate_key => $ssl_certificate_key,
                ssl_strict_transport_security => $ssl_strict_transport_security;
        }
    }
}
