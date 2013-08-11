class japsu::torrent {
	package {
		'rtorrent':
			ensure => present;
	}

	file {
		'/home/japsu/.rtorrent.session':
			require => User['japsu'],
			ensure => directory,
			owner => 'japsu';
		'/home/japsu/.rtorrent.rc':
			require => User['japsu'],
			ensure => present, source => 'puppet:///modules/japsu/rtorrent.rc',
			owner => 'japsu';
	}
}