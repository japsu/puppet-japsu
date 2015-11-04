class japsu::tracontent {
    define instance(
        $user,
        $listen,
        $repository='/srv/git/tracontent.git',
        $branch='staging',
    ) {
        japsu::django::instance {
            $title:
                user => $user,
                wsgi_app => 'tracontent.wsgi:application',
                listen => $listen,
                source => $repository,
                revision => $branch;
        }

        file {
            "/srv/www/$title/app/media":
                ensure => 'directory',
                owner => $user,
                group => $user,
                mode => 0755; # dr-xrwsrwx user-writable uploads folder

            [
                "/srv/www/$title/app/media/uploads",
                "/srv/www/$title/app/media/banners",
            ]:
                ensure => 'directory',
                owner => $user,
                group => $user,
                mode => 02775; # dr-xrwsrwx user-writable uploads folder
        }
    }

    define site(
        $instance,
        $template='nginx/proxy.conf.erb',
    ) {
        $listen = getparam(Japsu::Tracontent::Instance[$instance], 'listen')

        nginx::proxy {
            $title:
                target => "http://$listen",
                static_path => "/srv/www/$instance/app/static",
                media_path => "/srv/www/$instance/app/media",
                template => $template;
        }
    }
}
