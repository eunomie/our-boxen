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
  go::local { "/home/yves/go":
    version => '1.1.2'
  }

  include vlc
  include hipchat
  include cyberduck
  include hub
  include pgadmin3
  
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

  git::config::global {
    'user.name':     value => 'Yves Brissaud';
    'user.email':    value => 'yves@brissaud.name';

    'color.ui':      value => 'true';

    # so common alias
    'alias.st':            value => 'status';
    'alias.ci':            value => 'commit';
    'alias.br':            value => 'branch';
    'alias.co':            value => 'checkout';
    'alias.df':            value => 'diff';
    'alias.pr':            value => 'pull --rebase';

    # log
    # clean, oneline with graph
    'alias.oneline':       value => 'log --pretty=oneline --abbrev-commit --graph';
    'alias.lc':            value => 'log ORIG_HEAD.. --stat --no-merges';
    'alias.new':           value => '!sh -c \'git log $1@{1}..$1@{0} "$@"\'';
    # outgoing
    'alias.lout':          value => 'log --pretty=oneline --abbrev-commit --graph @{u}..';
    'alias.out':           value => '!git fetch && git lout';
    # incoming
    'alias.lin':           value => 'log --pretty=oneline --abbrev-commit --graph ..@{u}';
    'alias.in':            value => '!git fetch && git log --pretty=oneline --abbrev-commit --graph ..@{u}';

    # diff
    'alias.dic':           value => 'diff --cached';
    'alias.diffstat':      value => 'diff --stat';

    'alias.undo':          value => 'reset --soft HEAD^';

    # add modified files
    'alias.addm':          value => '!git-ls-files -m -z | xargs -0 git-add && git status';
    # add unknown files
    'alias.addu':          value => '!git-ls-files -o --exclude-standard -z | xargs -0 git-add && git status';
    # delete files marked as deleted
    'alias.rmm':           value => '!git ls-files -d -z | xargs -0 git-rm && git status';

    # server files
    'alias.serve':         value => 'daemon --reuseaddr --verbose  --base-path=. --export-all ./.git';

    # merge management
    # $ git edit-unmerged
    # $ ... edit ...
    # $ ... test ...
    # $ git add-unmerged
    # $ git commit  # or git rebase --continue or whatever
    'alias.edit-unmerged': value => '"!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; sub `f`"';
    'alias.add-unmerged':  value => '"!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; git add `f`"';

    # add github pull requests
    'alias.pullify':       value => 'config --add remote.origin.fetch \'+refs/pull/*/head:refs/remotes/origin/pr/*\'';
  }
}
