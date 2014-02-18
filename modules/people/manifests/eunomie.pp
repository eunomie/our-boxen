class people::eunomie {
  $home = "/Users/${::boxen_user}"

  package {'alfred':
    ensure => 'absent'
  }
  include skype
  include adobe_reader
  package {'adium':
    ensure => 'absent'
  }
  include virtualbox
  include firefox
  include libreoffice
  class { 'libreoffice::languagepack':
    locale => 'fr'
  }

  #include sourcetree
  package {'SourceTree':
    ensure => installed,
    provider => 'appdmg',
    source   => "http://downloads.atlassian.com/software/sourcetree/SourceTree_1.8.0.3.dmg"
  }
  include java
  include qt
  include iterm2::stable
  include sublime_text_2
  sublime_text_2::package {
    'Emmet':              source => 'sergeche/emmet-sublime';
    'Theme - nexus':      source => 'EleazarCrusader/nexus-theme';
    'Theme - Phoenix':    source => 'netatoo/phoenix-theme';
    'Theme - Flatland':   source => 'thinkpixellab/flatland';
    'Theme - itg.flat':   source => 'itsthatguy/theme-itg-flat';
    'SCSS':               source => 'danro/SCSS-sublime';
    'EditorConfig':       source => 'sindresorhus/editorconfig-sublime';
    'Alignment':          source => 'wbond/sublime_alignment';
    'GitConfig':          source => 'lifted-studios/Gitconfig.tmLanguage';
    'GitGutter':          source => 'jisaacks/GitGutter';
    'Puppet':             source => 'eklein/sublime-text-puppet';
    'ColorHighlighter':   source => 'Monnoroch/ColorHighlighter';
    'SublimeClojure':     source => 'Foxboron/SublimeClojure';
    'AngularJS':          source => 'angular-ui/AngularJS-sublime-package';
    'Sublime-CMakeLists': source => 'zyxar/Sublime-CMakeLists';
  }

  include sublime_text_3
  include sublime_text_3::package_control

  sublime_text_3::package {
    'Emmet':            source => 'sergeche/emmet-sublime';
    'Theme - Flatland': source => 'thinkpixellab/flatland';
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

  ruby::gem {"teamocil 1.9.3":
    gem => 'teamocil',
    ruby => "1.9.3",
    version => '~> 0.4.4'
  }

  ruby::gem {"compass":
    gem => 'compass',
    ruby => "1.9.3"
  }

  ruby::gem {"haml 1.9.3":
    gem => 'haml',
    ruby => "1.9.3"
  }

  ruby::gem {"sass 1.9.3":
    gem => 'sass',
    ruby => "1.9.3",
    version => "~> 3.2"
  }

  ruby::gem {"guard 1.9.3":
    gem => 'guard',
    ruby => "1.9.3"
  }

  ruby::gem {"guard-rake 1.9.3":
    gem => 'guard-rake',
    ruby => "1.9.3"
  }

  ruby::gem {"guard-sprockets2 1.9.3":
    gem => 'guard-sprockets2',
    ruby => "1.9.3"
  }

  ruby::gem {"coffee-script 1.9.3":
    gem => 'coffee-script',
    ruby => "1.9.3"
  }

  ruby::gem {"redcarpet 1.9.3":
    gem => 'redcarpet',
    ruby => "1.9.3"
  }

  ruby::gem {"pygments.rb 1.9.3":
    gem => 'pygments.rb',
    ruby => "1.9.3"
  }

  ruby::gem {"gollum 1.9.3":
    gem => 'gollum',
    ruby => "1.9.3"
  }

  ruby::gem {"serve 1.9.3":
    gem => 'serve',
    ruby => "1.9.3"
  }

  ruby::gem {"html_truncator 1.9.3":
    gem => 'html_truncator',
    ruby => "1.9.3",
    version => '~> 0.2'
  }

  ruby::gem {"sinatra 1.9.3":
    gem => 'sinatra',
    ruby => "1.9.3",
    version => '~> 1.4'
  }

  ruby::gem {"sprockets 1.9.3":
    gem => 'sprockets',
    ruby => "1.9.3",
    version => '~> 2.10'
  }

  ruby::gem {"sprockets-helpers 1.9.3":
    gem => 'sprockets-helpers',
    ruby => "1.9.3",
    version => '~> 1.1'
  }

  ruby::gem {"sprockets-sass 1.9.3":
    gem => 'sprockets-sass',
    ruby => "1.9.3",
    version => '~> 1.0'
  }

  ruby::gem {"uglifier 1.9.3":
    gem => 'uglifier',
    ruby => "1.9.3",
    version => '~> 2.4'
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

  include cmake

  include vagrant

  include inkscape

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
