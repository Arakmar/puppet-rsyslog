define rsyslog::config(
	$file_name = $name,
) {
	include rsyslog

	file { "/etc/rsyslog.d/${name}.conf":
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		mode    => 0644,
		source  => 
			["puppet:///modules/site-rsyslog/rsyslog.d/${file_name}.conf",
			"puppet:///modules/rsyslog/rsyslog.d/${file_name}.conf" ],
		require => Package['rsyslog'],
		notify  => Service['rsyslog'],
	}
}
