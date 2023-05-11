class php{

  package { 'php':
    ensure => installed,
  }
  
  package { 'php-gd':
    ensure => installed,
    require => Package['php'],
  }

  package { ['php-mysql', 'php-mysqli']:
    ensure => installed,
    require => Package['php'],
  }

  exec { 'php_extensions':
    command => '/bin/sed -i "s/;extension=mysqli.so/extension=mysqli.so/" /etc/php/7.2/cli/php.ini',
    require => Package['php-mysqli'],
  }
  
  file { '/etc/php/7.2/apache2/conf.d/30-mysqli.ini':
    content => 'extension=mysqli.so',
    require => Package['php-mysqli'],
    notify => Service['apache2'],
  }

  file { '/etc/php/7.2/cli/conf.d/30-mysqli.ini':
    content => 'extension=mysqli.so',
    require => Package['php-mysqli'],
    notify => Service['apache2'],
  }

  notify {'PHP installed':
    message => "PHP module was installed",
  }

}
