#
# Cookbook:: chefserver_bootstrap
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'chefserver_bootstrap::sshkeys'
include_recipe 'chefserver_bootstrap::setup'
