WARNING
=======

PATHS are given relative to ~/.emacs.d/!


Ideas
=====

The idea is to provide a simple setup for Emacs. However, the key
concept is to take it as a starting point and then (start to
re)configure everything from here on.

The concept of this configuration is:
   - Keep it simple and organized. And therefore,
   - Give a fuck about the starting time of Emacs (I got that 10
     seconds). This is also why I don't compile my *.el-files to have
     an increased start-up time.
   - Make it easy to use Emacs.
   - Make it easy to spread that Emacs configuration to several
     machines.


BTW there is no way around learning at least a little bit of (emacs)
lisp if you intend to use Emacs.


Keys (READ the 5 paragraphs!):
==============================

Most main keys are left as it was. So I will not list them here.
However, changes were made of course. For example: C-w was set to
backward-kill-word (which deletes the word before cursor). This is the
standard Unix Terminal way. Kill region, which has originally was at
C-w, is not at C-c C-k.

Keys are set in 24/basic_keys.el and in the configuration files for
the packages (24/package_config/*) and languages
(24/language_configs/*).

Ensure you get used to the basic keys from 24/basic_keys.el!
Afterwards, when you start using a package you need to check the
specific package and language configuration. For example if you intend
to use the org mode (which is set default for text files), check out
24/packages_configs/org_mode_config.el for the specific configuration.


There is a prefix command for most user-defined key strokes. It can be
defined in the settings.el file, the default is C-x x.

Have a look at ~/.emacs.d/24/basic_keys.el for the main keys.

Example (with prefix beeing C-x x):

| Key       | Function                | Description                                 |
|-----------+-------------------------+---------------------------------------------|
| C-x x C-q | save-buffers-kill-emacs | close emacs                                 |
| C-x x c   | eshell                  | a shell inside of emacs                     |
| C-x x r   | replace-regexp          | find and replace using a REGular EXpression |
| ...       |                         | check out the files and get used to them    |


How to Install
==============

If you can't wait/or just don't want to:
 - install all packages listed below.
 - you need to create a settings.el file in ./emacs.d/settings.el (see settings.el.example)
 - you need to fire up emacs - all packages will be downloaded
 - it should automatically compile cedet. Check if that worked out!
 - you need to restart emacs (cedet doesn't like it, when new packages get installed)


Fedora:
-------

su -c "yum install ctags-etags gnuplot emacs graphviz \                # main tools
w3m && \                                                               # browser for links
texlive evince &&  \                                                   # LaTeX
cabal install hasktags && \                                            # Haskell
perl-CPAN mariadb-devel && cpan -fi Module::Build::Compat && \         # database tools
cpan -fi RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql" && \    # database tools
echo "(load-file \"~/.emacs.d/gnus.el\")" > ~/.gnus.el && \            # create gnus file
# cd ~/.emacs.d/24/packages/cedet/ && make && \                          # compile cedet
mv ~/.emacs.d/settings.el.example ~/.emacs.d/settings.el && \          # settings.el
&& emacs -mm                                                           # start emacs maximized


1. Wait until packages are downloaded and installed.
2. Then restart emacs.
3. Edit ~/.emacs.d/settings.el to your needs
4. Check the source files. You still need to know how to (re)configure Emacs works!


Dependencies:
-------------

+ Main dependencies
  - emacs
  - ctags-etags

+ Java
  - w3m (Javadoc Lookup inside of Emacs)

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


If you got any questions, don't hesitate to contact me at "manuel.schneckiXYZgmail.com[@/XYZ]".


How is this package built up?
=============================

.emacs.d
   - README.md               This file.
   + snippets                Snippets folder.
       - ...                 Folders for different modes (programming languages)
   + .tmp                    Backup and flymake files.
       - ...
   - init.el ***             The start point of the config. Sets package list.
   + 24  [Emacs Version]
       - emacs.el            The start point inside of this folder, loads following:
       - basics.el           Some basic functions and settings (mostly for built in tools).
       - basic_keys.el       Basic key sequences (mostly for built in functions).
       + package_configs     Contains configuration files for packages (loaded by emacs.el).
          - ...              Check it out!
       + packages            All additional packages (not available from Pamela).
          - ...              Check it out!
       + language_configs    Own configuration for each (programming) language.
          - ...              Check it out!


OK, when starting up Emacs following chain is used for loading the
configuration files: (Emacs automatically starts ~/.emacs.d/init.el)


    init el    ->    24/emacs el
     \                \
      \ settings el    \ basics el
                        \ 24/package_config/* el    ->     24/packages/*
                         \ basic_keys el
                          \ language_configs/* el


This means init.el is started and load settings.el, afterwards it
loads 24/emacs.el. This file then lads basics.el


Where is the sense?
-------------------

Well, if you got a problem with one package. Then you go to
24/emacs.el and disable the package before you try to find out what
caused the problem.


If you dig a little bit around in the config files you will be able to
find out quite a lot.


Interesting to Know
===================


 - Automatic Tag generation:

   Tags file are created automatically and set. Configured is this
   behavior in each language configuration file. It looks for a folder
   named "src" and places the TAGS file right above it. This means if
   you got a project folder that looks like this:

    + ProjectFolder
       + src
          - ...    (Your source code.)
       - ...       (then a TAGS file will be placed right here)
       - TAGS

   However, there is one exception: If you edit .el files, the TAGS
   file is placed in ~./emacs.d/TAGS.

 - Have a look at my Makefiles: github.com/schnecki

   They work quite well with the configuration.

 - There is a Firefox plugin for Emacs users:

   https://github.com/mooz/keysnail/wiki

   Furthermore, you might want to install some plugins:
   https://github.com/mooz/keysnail/wiki/plugin
