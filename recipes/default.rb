#
# Cookbook:: chefserver-bootstrap
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'chefserver-bootstrap::sshkeys'
include_recipe 'chefserver-bootstrap::setup'
