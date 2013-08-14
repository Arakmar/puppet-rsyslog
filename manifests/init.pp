class rsyslog (
	$remote_logging = true,
	$protocol = 'tcp',
	$server = '127.0.0.1',
	$server_port = 514,
	$enable_tcp                = true,
	$enable_udp                = true,
	$high_precision_timestamps = false,
	$is_rsyslog_server = 'false'
) {
	service { "rsyslog":
		ensure  => running,
		enable  => true,
	}
	
	package { "rsyslog":
		ensure => "installed",
	}
	
	file { "/etc/rsyslog.d":
                ensure  => directory,
                owner   => root,
                group   => root,
                mode    => 0755,
                purge => true,
                force => true,
                recurse => true,
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
	
	if $is_rsyslog_server {
                $conf_template = 'rsyslog/server.conf.erb'
	}
	else {
                $conf_template = 'rsyslog/client.conf.erb'
	}

        file { "/etc/rsyslog.conf":
                ensure  => present,
                owner   => root,
                group   => root,
                mode    => 0644,
                content => template($conf_template),
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}
