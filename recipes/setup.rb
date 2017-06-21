include_recipe 'chefserver_bootstrap::sshkeys'

# Install Chef Server
chef_ingredient "chef-server" do
  version '12.15.6'
  config <<-EOS
api_fqdn "#{node["fqdn"]}"
ip_version "ipv6"
notification_email "#{node["chef_admin"]}"
nginx["ssl_protocols"] = "TLSv1 TLSv1.1 TLSv1.2"
EOS
  accept_license true
end

ingredient_config "chef-server" do
  notifies :reconfigure, "chef_ingredient[chef-server]"
end

# Create Chef Server Users & Orgs
execute 'create-admin-user' do
  command 'chef-server-ctl user-create admin Web Master admin@thnkbig admin --filename /opt/admin.pem'
  not_if 'chef-server-ctl user-list | grep "admin"'
end

execute 'create-organization' do
  command 'chef-server-ctl org-create thnkbig "Thnkbig, Inc" --association_user admin --filename /opt/thnkbig-validator.pem'
  not_if 'chef-server-ctl org-list | grep "thnkbig"'
end

# Install Chef Manage
chef_ingredient 'manage' do
  channel :stable
  action :install
end

execute 'chef-server-ctl reconfigure' do
  command 'chef-server-ctl reconfigure'
  action :run
end

execute 'chef-manage-ctl reconfigure' do
  command 'chef-manage-ctl reconfigure --accept-license --yes'
  action :run
end

# Install Chef Push Jobs
chef_ingredient 'push-jobs-server' do
  channel :stable
  action :install
end

execute 'chef-server-ctl reconfigure' do
  command 'chef-server-ctl reconfigure'
  action :run
end

execute 'opscode-push-jobs-server-ctl reconfigure' do
  command 'opscode-push-jobs-server-ctl reconfigure'
  action :run
end

ingredient_config "chef-server" do
  notifies :reconfigure, "chef_ingredient[push-jobs-server]"
end
#execute 'chef-server-ctl reconfigure' do
#  command 'chef-server-ctl reconfigure'
#  action :run
#end

#execute 'chef-manage-ctl reconfigure' do
#  command 'chef-manage-ctl reconfigure --accept-license --yes'
#  action :run
#end
#execute 'chef-server-ctl reconfigure' do
#  command 'chef-server-ctl reconfigure'
#  action :run
#end

#execute 'chef-manage-ctl reconfigure' do
#  command 'chef-manage-ctl reconfigure --accept-license --yes'
#  action :run
#end

# SSH and Git
git_client 'default' do
  action :install
end

git_config 'Chef Server name' do
  user 'root'
  scope 'global'
  key 'user.name'
  value 'Chef Server'
end

git_config 'Chef Server email' do
  user 'root'
  scope 'global'
  key 'user.email'
  value 'admin@thnkbig.com'
end
