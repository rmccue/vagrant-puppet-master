# Although this is declared in myproject, we can declare it here as well for
# clarity with dependencies
package {'php5-fpm':
	ensure => latest
}
class { 'mysql::php':
	require => [ Class['mysql::server'], Package['php5-fpm'] ],
}
class { 'mysql::server':
	config_hash => { 'root_password' => 'password' }
}

file { '/var/www':
	ensure => directory
}

class {'myproject': }
myproject::site {'vagrant.local':
	location => '/var/www/vagrant.local',
	require  => [ Class['mysql::server'], Package['php5-fpm'], Class['mysql::php'] ]
}