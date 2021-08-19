define rsyslog::config(
	$file_name = $name,
	$source
) {
	if !defined(Class['rsyslog']) {
		fail('You must include the rsyslog base class before using any rsyslog defined resources')
	}

	file { "/etc/rsyslog.d/${name}.conf":
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		source  => $source,
		require => Package['rsyslog'],
		notify  => Service['rsyslog'],
	}
}
