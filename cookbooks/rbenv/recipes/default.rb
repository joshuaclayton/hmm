default_user = ENV["SUDO_USER"]
home = "/home/#{default_user}"
rbenv_path = "#{home}/.rbenv"
profile_path = "#{home}/.profile"

%w[libreadline5-dev libssl-dev libxml2-dev].each do |pkg|
  package pkg do
    action :install
  end
end

bash "load rbenv" do
  user  default_user
  group default_user
  code <<-EOF
    rm -f #{profile_path}
    echo 'export PATH="#{rbenv_path}/bin:$PATH"' >> #{profile_path}
    echo 'eval "$(rbenv init -)"' >> #{profile_path}
    source #{profile_path}
  EOF
end

bash "prep rbenv" do
  user  default_user
  group default_user

  code <<-EOF
    rm -rf #{rbenv_path}
    git clone git://github.com/sstephenson/rbenv.git #{rbenv_path}
    mkdir -p #{rbenv_path}/plugins
    cd #{rbenv_path}/plugins
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build
    PREFIX=#{rbenv_path} ./install.sh
  EOF

  not_if "dir #{rbenv_path}/plugins/ruby-build"
end

bash "install rbenv" do
  code <<-EOF
    source #{profile_path}
    rbenv install 1.9.3-p125
    rbenv rehash
    rbenv global 1.9.3-p125
  EOF

  not_if "rbenv version | grep 1.9.3-p125"
end
