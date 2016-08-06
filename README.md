# Vagrant environment

This project provides a virtual environment for Web project
[Vagrant](https://www.vagrantup.com).

## What's in the box?

- Git
- Composer
- cURL
- nginx
- PHP 5.6 or 7.0
- MariaDb
- NodeJs & npm
- Redis
- RabbitMQ

Support Multi virtualhost

## Requirement

- Vagrant > 1.4
    + hostmanager plugin
    + vbguest plugin
- Ansible ~ 1.9

## Customization

Change sync folder and host name Vagrantfile
Change ./ansible/vars/vagrant.yml