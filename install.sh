apt-get update
apt-get -y upgrade
apt-get -y install python-software-properties


if [ ! -f /etc/apt/sources.list.d/chris-lea-node_js-precise.list ]; then
  add-apt-repository -y ppa:chris-lea/node.js
fi

if [ ! -f /etc/apt/sources.list.d/chris-lea-redis-server-precise.list ]; then
  add-apt-repository -y ppa:chris-lea/redis-server
fi

# add chrome repository
if [ ! -f /etc/apt/sources.list.d/google.list ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
fi

apt-get update

apt-get -y install \
  ubuntu-desktop\
  python\
  python-dev\
  python-virtualenv\
  fabric\
  git-core\
  postgresql-server-dev-9.1\
  libjpeg-dev\
  libpng-dev\
  libxml2-dev\
  libxslt1-dev\
  geoip-database\
  geoip-bin\
  libjpeg8-dev\
  libgeoip-dev\
  unattended-upgrades\
  build-essential\
  postgresql-9.1\
  postgresql-contrib-9.1\
  g++\
  make\
  libfreetype6\
  libfreetype6-dev\
  zlib1g-dev\
  mysql-client-5.5\
  git-all\
  vim\
  mysql-server-5.5\
  redis-server\
  nodejs\
  google-chrome-stable\
  linux-headers-generic\
  dkms\
  curl\
  mercurial

apt-get -y autoremove

echo "---- INSTALLING LESS" 
command -v lessc || npm install -g less

su ben << EOF
  cd \$HOME
  echo "---- INSTALLING rbenv ruby"

  if [ ! -d .rbenv ]; then
    git clone git://github.com/sstephenson/rbenv.git .rbenv
  fi

  if [ ! -d .rbenv/plugins/ruby-build ]; then
    git clone git://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build
  fi

  export PATH="\$HOME/.rbenv/bin:\$HOME/.rbenv/plugins/ruby-build/bin:\$PATH"
  eval "\$(rbenv init -)"
  rbenv install 2.1.3 
  rbenv global 2.1.3

  echo "---- INSTALLING dotfiles"

  cd \$HOME
  touch .ssh/config
  grep github.com .ssh/config ||\
    echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> .ssh/config
  if [ ! -d Projects/dotfiles ]; then
    mkdir -p Projects
    cd Projects
    git clone git@github.com:techbelly/dotfiles.git dotfiles
  fi 
  env
  cd \$HOME/Projects
  cd dotfiles && ruby ./install.rb
EOF

update-locale LANG=en_GB.UTF-8 LC_MESSAGES=POSIX LC_ALL=en_GB.UTF-8

gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"


