define myproject::site (
	$location,
	$database = 'wordpress',
	$database_user = 'root',
	$database_password = 'password',
	$database_host = 'localhost'
) {
	file { $location:
		ensure => directory
	}
	file { "/etc/nginx/sites-available/$name":
		content => template('myproject/site.nginx.conf.erb'),
		notify => Service['nginx']
	}
	file { "/etc/nginx/sites-enabled/$name":
		ensure => link,
		target => "/etc/nginx/sites-available/$name",
		notify => Service['nginx']
	}

	mysql::db {$database:
		user     => $database_user,
		password => $database_password,
		host     => $database_host,
		grant    => ['all'],
	}
}