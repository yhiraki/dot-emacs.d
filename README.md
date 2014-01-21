Instructions will follow. However, might take a while...

--

If you can't wait/or just don't want to:
 - you need to compile cedet. ~/.emacs.d/24/packages/cedet
 - you need to create a settings.el file in ./emacs.d/settings.el
 - you need to fire up emacs - all packages will be downloaded
 - you need to restart emacs (cedet doesn't like it, when new packages get installed)


Fedora:

su -c "yum install ctags-etags gnuplot emacs graphviz \                # main tools
texlive evince &&  \                                                   # LaTeX
cabal install hasktags && \                                            # Haskell
perl-CPAN mariadb-devel && cpan -fi Module::Build::Compat && \         # database tools
cpan -fi RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql"         # database tools


Dependencies:

+ Main dependencies
  - emacs
  - ctags-etags

+ Org Mode
  - gnuplot (optional)
  - graphviz

+ Latex:
  - evince (change latex_config.el to use other pdf-viewer)
  - texlive

+ Haskell
  - cabal (of course)
  - hasktags ($ cabal install hasktags)

+ Database Viewer: edbi
  - perl-CPAN
  - and cpan modules:
     - RPC::EPC::Service
     - DBI
     - DBI driver and (using DB depending on):
          - DBD::SQLite        ( SQLite )
          - DBD::Pg            ( Postgresql )
          - DBD::mysql         ( MySQL )
  - therefore: cpan -fi RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql
  - connection parameters for edbi:
     sqlite : dbi:SQLite:dbname=/path/to/database.sqlite
     postgresql : dbi:Pg:dbname=mydb
     mysql : dbi:mysql:mydb
  - more information: https://github.com/kiwanami/emacs-edbi


If you got questions, don't hesitate to contact me at "manuel.schneckiXYZgmail.com" [Q/XYZ]
