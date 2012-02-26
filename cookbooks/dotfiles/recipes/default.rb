default_user = ENV["SUDO_USER"]
vagrant_home = "/home/#{default_user}"

bash "clone dotfiles" do
  user  default_user
  group default_user

  code "git clone git://github.com/joshuaclayton/dotfiles.git #{vagrant_home}/.dotfiles"
  not_if "dir #{vagrant_home}/.dotfiles"
end

# bash "install dotfiles" do
#   user  default_user
#   group default_user
# 
#   cwd "#{vagrant_home}/.dotfiles"
#   code <<-EOF
#     rake install
#   EOF
# 
#   not_if "[[ -h #{vagrant_home}/.irbrc ]]"
# end
