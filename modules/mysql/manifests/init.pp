class mysql {
  $path = '/usr/bin/mysql'

  package { 'mysql-server':
    ensure => installed,
  }

  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package['mysql-server'],
    restart => true,
  }

  exec { 'create database':
    command => "${path} -e \"CREATE DATABASE ${$database_name}\"",
    unless  => "${path} -e \"SHOW DATABASES\" | grep -q ${$database_name}",
    require => Service['mysql'],
  }

  exec { 'create user':
    command => "${path} -e \"CREATE USER '${database_user}'@'localhost' IDENTIFIED BY '${$database_password}'\"",
    unless  => "${path} -e \"SELECT User FROM mysql.user WHERE User = '${database_user}'\" | grep -q ${database_user}",
    require => Service['mysql'],
  }

  exec { 'grant permissions':
    command => "${path} -e \"GRANT ALL PRIVILEGES ON ${$database_name}.* TO '${database_user}'@'localhost'\"",
    unless  => "${path} -e \"SHOW GRANTS FOR '${database_user}'@'localhost'\" | grep -q \"GRANT ALL PRIVILEGES ON ${$database_name}.* TO '${database_user}'@'localhost'\"",
    require => [
      Service['mysql'],
      Exec['create database'],
      Exec['create user'],
    ],
  }

  notify { 'mysql installed':
    message => "MySQL module was installed and ${$database_name} was created",
    require => [
      Service['mysql'],
      Exec['create database'],
      Exec['create user'],
    ],
  }
}
