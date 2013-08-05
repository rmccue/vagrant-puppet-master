class myproject {
	if ! defined(Package['nginx']) {
		package {'nginx':
			ensure => latest
		}
	}
	if ! defined(Package['php5-fpm']) {
		package {'php5-fpm':
			ensure => latest
		}
	}
	service { 'nginx':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		restart    => '/etc/init.d/nginx reload',
		require    => Package['nginx']
	}
}