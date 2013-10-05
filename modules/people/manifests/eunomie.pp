class people::eunomie {
  $home = "/Users/${::boxen_user}"

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
  sublime_text_2::package {
    'Emmet':         source => 'sergeche/emmet-sublime';
    'Theme - nexus': source => 'EleazarCrusader/nexus-theme';
    'SCSS':          source => 'danro/SCSS-sublime';
  }

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

  include go
  go::version {'1.1.2': }
  include go::1_1
  go::local { "{$home}/go":
    version => '1.1.2'
  }
  
  $perso = "${home}/perso"
  $dotfiles = "${perso}/dotfiles"
  $blog = "${perso}/log.winsos.net"
  $wlt = "${perso}/wlt"

  file { $perso :
       ensure => directory
  }

  repository {
    $dotfiles: source => 'eunomie/dotfiles', require => File[$perso];
    $blog:     source => 'eunomie/log.winsos.net', require => File[$perso];
    $wlt:      source => 'eunomie/wlt', require => File[$perso];
  }

}
