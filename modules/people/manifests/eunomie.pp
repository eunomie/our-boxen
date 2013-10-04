class people::eunomie {
  include alfred
  include skype
  include adobe_reader
  include adium
  include onyx
  include virtualbox
  include firefox
  include libreoffice
  include libreoffice::languagepack
  class { 'libreoffice::languagepack':
    locale => 'fr'
  }

  include sourcetree
  include java
  include qt
  include iterm2::stable
  include sublime_text_2
  #sublime_text_2::package { 'Emmet':
  #  source => 'sergeche/emmet-sublime'
  #}

  include dropbox
  include emacs
  include chrome
  include zsh
  include screen
  include sparrow
  include clojure
  include jumpcut
  include keepassx
  include pow
  
  $home = "/Users/${::boxen_user}"
  $perso = "${home}/perso"

  file { $perso :
       ensure => directory
  }

}