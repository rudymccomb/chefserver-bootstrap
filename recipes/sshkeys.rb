
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

ssh_keygen '/root/.ssh/id_rsa' do
  action :create
  owner 'root'
  group 'root'
  strength 4096
  type 'rsa'
  comment 'admin@thnkbig.com'
  secure_directory true
end

file '/tmp/git_wrapper.sh' do
  mode 0700
  user 'root'
  group 'root'
  content <<-EOH
    #!/bin/bash
    exec /usr/bin/ssh \
    -o CheckHostIP=no \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o PasswordAuthentication=no \
    -o IdentityFile=/root/.ssh/id_rsa.pub \
    "$*"
    EOH
end

#git '/opt' do
#  action :sync
#  repository 'git@github.com:rudymccomb/chef-server.git'
#  revision 'master'
#  ssh_wrapper '/tmp/git_wrapper.sh'
#end

#file "/tmp/ssh_wrapper.sh" do
#  content
#  "#!/bin/sh\nexec /usr/bin/ssh -i #{/tmp/key.pem}
#  -o UserKnownHostsFile=/dev/null
#  -o StrictHostKeyChecking=no \"$@\""
#  user "root"
#  group "root"
#  mode "0700"
#  action :create
#end
