package "zsh" do
  action :install
end

bash "change shell to zsh" do
  code <<-EOF
    chsh -s /usr/bin/zsh $SUDO_USER
    chsh -s /usr/bin/zsh $USER
    chsh -s /usr/bin/zsh
    zsh
  EOF

  not_if "[[ $0 = '-zsh' ]]"
end
