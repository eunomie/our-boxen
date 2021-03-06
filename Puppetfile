# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.3.8"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",    "1.0.1"
github "gcc",        "2.0.1"
github "git",        "1.3.7"
github "homebrew",   "1.6.0"
github "hub",        "1.3.0"
github "inifile",    "1.0.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.3"
github "nodejs",     "3.5.0"
github "openssl",    "1.0.0"
github "phantomjs",  "2.1.0", :repo => "eunomie/puppet-phantomjs"
github "pkgconfig",  "1.0.0"
github "repository", "2.3.0"
github "ruby",       "7.2.3"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.1"


# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "alfred",         "1.1.5" #absent
github "adium",          "1.2.0" #absent

github "osx",            "2.2.2"
github "skype",          "1.0.8"
github "adobe_reader",   "1.1.0"
github "virtualbox",     "1.0.10"
github "firefox",        "1.1.8"
github "libreoffice",    "4.1.4"
github "sourcetree",     "1.0.1", :repo => "eunomie/puppet-sourcetree"
github "java",           "1.2.0"
github "qt",             "1.2.2"
github "iterm2",         "1.0.7"
github "sublime_text_2", "1.1.2"
github "sublime_text_3", "1.0.2", :repo => "jozefizso/puppet-sublime_text_3"
github "dropbox",        "1.2.0"
github "emacs",          "1.2.0"
github "chrome",         "1.1.2"
github "zsh",            "1.0.0"
github "screen",         "1.0.0"
github "sparrow",        "1.0.0"
github "clojure",        "1.2.0"
github "jumpcut",        "1.0.0"
github "keepassx",       "1.0.0"
github "pow",            "1.0.0"
github "go",             "2.0.1"
github "vlc",            "1.0.5"
github "vagrant",        "3.0.4"
github "hipchat",        "1.1.0"
github "cyberduck",      "1.0.1"
github "pgadmin3",       "1.0.0"
github "mongodb",        "1.2.0"
github "tmux",           "1.0.2"
github "textual",        "4.1.1"
github "skitch",         "1.0.2"
github "cmake",          "1.0.1"
github "inkscape",       "1.0.3"
