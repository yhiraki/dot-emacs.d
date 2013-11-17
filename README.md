Instructions will follow.

--

If you can't wait:
 - you need to compile cedet. ~/.emacs.d/24/packages/cedet
 - you need to create a settings.el file in ./emacs.d/settings.el
 - you need to fire up emacs - all packages will be downloaded
 - you need to restart emacs (cedet doesn't like it, when new packages get installed)


Fedora: sudo yum install ctags-etags gnuplot emacs evince texlive graphviz

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
