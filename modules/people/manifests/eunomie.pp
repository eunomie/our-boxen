class people::eunomie {
  $home = "/Users/${::boxen_user}"

  include alfred
  include skype
  include adobe_reader
  include adium
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
    'Emmet':            source => 'sergeche/emmet-sublime';
    'Theme - nexus':    source => 'EleazarCrusader/nexus-theme';
    'SCSS':             source => 'danro/SCSS-sublime';
    'EditorConfig':     source => 'sindresorhus/editorconfig-sublime';
    'Alignment':        source => 'wbond/sublime_alignment';
    'GitConfig':        source => 'lifted-studios/Gitconfig.tmLanguage';
    'GitGutter':        source => 'jisaacks/GitGutter';
    'Puppet':           source => 'eklein/sublime-text-puppet';
    'ColorHighlighter': source => 'Monnoroch/ColorHighlighter';
    'SublimeClojure':   source => 'Foxboron/SublimeClojure';
    'AngularJS':        source => 'angular-ui/AngularJS-sublime-package';
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
  include tmux
  include textual

  include go
  go::version {'1.1.1': }

  include vlc
  include hipchat
  include cyberduck
  include hub
  include pgadmin3

  include mongodb

  include phantomjs::1_9_0
  #phantomjs::global { '1.9.0': }

  ruby::gem {"teamocil 1.9.3":
    gem => 'teamocil',
    ruby => "1.9.3",
    version => '~> 0.4.4'
  }

  ruby::gem {"compass":
    gem => 'compass',
    ruby => "1.9.3"
  }

  package { 'Casperjs':
    ensure => installed,
    source => 'https://github.com/n1k0/casperjs/archive/1.1-beta1.zip',
    provider => 'compressed_app'
  }
  exec { "make symbolic link for casperjs":
    command => "ln -sf /Applications/casperjs-1.1-beta1/bin/casperjs /usr/local/bin/casperjs",
    unless => "test -x /user/local/bin/casperjs && /usr/local/bin/casperjs --version | grep '\\bv1.1-beta1\\b'",
    user => 'root'
  }

  package { 'python':
    ensure => installed
  }

  package { 'mdr':
    ensure => installed,
    source => 'https://github.com/halffullheart/mdr/archive/v1.0.0-beta.2.tar.gz',
    provider => 'compressed_app'
  }

  include osx::dock::clear_dock
  include osx::disable_app_quarantine
  include osx::no_network_dsstores

  include skitch
  
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

    'push.default': value => 'simple';

    'color.ui':      value => 'true';

    # so common alias
    'alias.st':            value => 'status';
    'alias.ci':            value => 'commit';
    'alias.br':            value => 'branch';
    'alias.co':            value => 'checkout';
    'alias.df':            value => 'diff';
    'alias.pr':            value => 'pull --rebase';
    'alias.pull':          value => 'pull --ff-only';
    'alias.up':            value => 'merge --ff-only';
    'alias.join':          value => 'merge --no-ff';

    # stash
    'alias.shelve':        value => 'stash save --include-untracked';
    'alias.unshelve':      value => 'stash pop';

    # remotes
    'alias.fo':            value => 'fetch origin';
    'alias.fu':            value => 'fetch upstream';

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
    'alias.edit-unmerged': value => '"!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; subl `f`"';
    'alias.add-unmerged':  value => '"!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; git add `f`"';

    # add github pull requests
    'alias.pullify':       value => 'config --add remote.origin.fetch \'+refs/pull/*/head:refs/remotes/origin/pr/*\'';

    # mdr
    'alias.mdr':           value => '!git diff | mdr';
    'alias.mdc':           value => '!git diff --cached | mdr';
  }
}
