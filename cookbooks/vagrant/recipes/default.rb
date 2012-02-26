execute "apt-get update" do
  user "root"
end

%w[curl wget tree].each do |pkg|
  package pkg do
    action :install
  end
end

require_recipe "git"
require_recipe "tmux"
require_recipe "zsh"
require_recipe "vim"
require_recipe "rbenv"
require_recipe "dotfiles"
