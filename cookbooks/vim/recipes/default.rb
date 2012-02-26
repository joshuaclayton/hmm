%w[vim-nox exuberant-ctags].each do |pkg|
  package pkg do
    action :install
  end
end
