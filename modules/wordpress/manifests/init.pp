class wordpress {
  $wp_cli_path = '/usr/local/bin/wp '

  # Install wp-cli
  exec { 'Install wp-cli':
    command => "/usr/bin/curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && sudo mv wp-cli.phar ${wp_cli_path}",
  }

  # Download and install WordPress
  exec { 'Download and install WordPress':
    command => "${wp_cli_path} core download --path=${wordpress_path} --allow-root",
    creates => "${wordpress_path}/wp-config.php",
  }

  # Configure WordPress
  exec { 'Configure WordPress':
    command => "${wp_cli_path} core config --dbname=${database_name} --dbuser=${database_user} --dbpass=${database_password} --path=${wordpress_path} --allow-root",
    require => Exec['Download and install WordPress']
  }

  # Install WordPress
  exec { 'Install WordPress':
    command => "${wp_cli_path} core install --url=192.168.33.10 --title='${wordpress_title}' --admin_user='${wordpress_admin_user}' --admin_password='${wordpress_admin_password}' --admin_email='${wordpress_admin_email}' --path=${wordpress_path} --allow-root",
    require => [
      Exec['Configure WordPress'],
    ],
    unless  => "${wp_cli_path} core is-installed --path=${wordpress_path} --allow-root",
  }

  file { "${wordpress_path}":
    ensure  => 'directory',
  }

  # Configure Routes
  exec { 'Configure Routes':
    command     => "${wp_cli_path} rewrite structure '/%postname%/' --allow-root && ${wp_cli_path} rewrite flush --allow-root",
    cwd         => "${wordpress_path}",
    refreshonly => true,
  }

  # Configure home  
  exec { 'Configure home':
    command     => "${wp_cli_path} option update show_on_front posts --allow-root",
    cwd         => "${wordpress_path}",
    refreshonly => true,
  }
 
  # Verify home
  exec { 'Verify home':
    command     => "${wp_cli_path} option get show_on_front --allow-root",
    cwd         => "${wordpress_path}",
    refreshonly => true,
  }

}
