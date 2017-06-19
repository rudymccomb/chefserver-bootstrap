name 'chefserver-bootstrap'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures chefserver-bootstrap'
long_description 'Installs/Configures chefserver-bootstrap'
version '0.1.2'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/chefserver-bootstrap/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/chefserver-bootstrap'
%w(apt yum chef-sugar chef-ingredient git ssh_keygen line).each do |cookbook|
  depends cookbook
end
