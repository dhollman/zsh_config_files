My .zshrc file and other configuration miscellany 
=================================================

This repo contains my zshrc file and related scripts.  It probably 
won't help you much, but you are welcome to poke around at it and 
fork it if you like.  It is in the public domain.

Notes to myself
===============

Here's a bunch of notes to myself about how to use this repo and scripts 
and such.  You can read them if you want, but if you don't understand them,
don't blame me.  You've been warned.


Machine-specific files used by the zshrc file
---------------------------------------------
All of these are protected by `if [ -e file ]` statements, but some of them 
it would be silly to exclude

*  .zsh/paths directory:
     * .zsh/paths/path.zsh
*  .zsh/aliases.zsh
*  .zsh/environment.zsh
*  .zsh/hash_directories.zsh
*  .zsh/oh-my-zsh-plugins.zsh
*  .zsh/working_environments directory:
     * Anything in this directory or its subdirectories will be made into an 
       alias (with .zsh omitted) that sources that file.  For instance, the 
       presence of .zsh/working_environments/work_rb.zsh would alias work_rb 
       to source .zsh/working_environments/work_rb.zsh.  
     * Any subdirectory of this directory can have .before.zsh and .after.zsh 
       scripts that are run before and after the content of any of the alias 
       files in that directory when that alias is called.

Machine-specific environment variables
--------------------------------------
* $ZSH_REPO must be set to the directory of the zsh config scripts repository (i. e. the directory that this file is in)
* $NO_OH_MY_ZSH can be set to anything to prevent oh-my-zsh from loading.  (use `unset` to unset it) 
* $ENABLE_ZSH_HIGHLIGHTING can be set to false to turn off syntax highlighting (it is true by default)


