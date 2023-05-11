$wordpress_path = '/var/www/html'
$wordpress_title = 'Title Site'
$wordpress_admin_user = 'webmaster'
$wordpress_admin_password = 'password'
$wordpress_admin_email = 'webmaster@example.com'
$database_name = 'wordpress_db'
$database_user = 'wpuser'
$database_password = 'wppassword'

require apache2
require php
require mysql
require wordpress


notify { 'Showing machine Facts':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s.
              Please check access to http://$::ipaddress_enp0s8}",
}
