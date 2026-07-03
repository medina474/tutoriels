#!/bin/bash

cd $1

composer require symfony/twig-bundle symfony/asset symfony/asset-mapper symfony/orm-pack symfony/form symfony/validator symfony/mailer symfony/ux-icons monolog-bundle symfony/messenger
