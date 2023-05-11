
# Install WordPress in Vagrant + Puppet
## Setup
* **Step 1**: Download and install [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Usage
* **Step 1**: Clone/Download this repository, unzip it to a folder and change directory to that folder with Command Terminal

* **Step 2**: In Terminal, run the command
```
vagrant up 
```
* **Step 3**: Files and folders in manifest and modules are synced to the VM. 

* **Step 4**: Vagrantfile's file contains this configuration config.vm.network "private_network", ip: "192.168.33.40", when your VM is synced navigate to [192.168.33.10](http:192.168.33.10) to watch the results. 

## Documentation

The default.pp file in main manifest folder contains variables used in MySQL and WordPress configuration and import the modules needed to set Apache, MySQL, PHP and WordPress

