#!/usr/bin/env ruby

# from http://errtheblog.com/posts/89-huba-huba

home = ENV['HOME']

Dir.chdir File.dirname(__FILE__) do
  dotfiles_dir = Dir.pwd.sub(home + '/', '')

  Dir['*'].each do |file|
    next if file == 'install.rb'
    target_name = file == 'bin' ? file : ".#{file}"
    target = File.join(home, target_name)
    unless File.exist? target
      system %[ln -vsf #{File.join(dotfiles_dir, file)} #{target}]
    end
  end
end

puts("Installing homebrew")

install = <<EOF
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
EOF

system(install)
system("brew bundle --global")
