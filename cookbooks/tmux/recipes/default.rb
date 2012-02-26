%w[libevent-dev libncurses5-dev wget].each do |pkg|
  package pkg do
    action :install
  end
end

bash "install tmux" do
  cwd "/tmp"
  code <<-EOF
    wget http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz
    tar xvf tmux-1.6.tar.gz
    cd tmux-1.6
    ./configure && make && sudo make install
  EOF

  not_if "which tmux"
end
