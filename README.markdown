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
     * .zsh/paths/fpath.zsh
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
*  .zsh/source_last.zsh
*  Check the sample_zsh_local_dir for example structure

Machine-specific environment variables
--------------------------------------
*  `$ZSH_REPO` must be set to the directory of the zsh config scripts repository (i. e. the directory that this file is in)
*  `$ZSH_LOCAL` can be set to use something other than $HOME/.zsh for the machine-specific files directory
*  `$NO_OH_MY_ZSH` can be set to anything to prevent oh-my-zsh from loading.  (use `unset` to unset it) 
*  `$ENABLE_ZSH_HIGHLIGHTING` can be set to false to turn off syntax highlighting (it is true by default)

Setup Process on a New Machine
------------------------------
1.  Set up ssh keys and such on the new machine:
      *  Run `ssh-keygen` to generate the key pair.
      *  Copy the file `id_rsa.pub` to `<descr. of machine>.rsapub`
      *  scp the .rsapub file to wherever the new machine needs ssh access to, then on those machines,
         append it to the end of the ~/.ssh/authorized_keys file.
      *  Do the same process in reverse for any machines you need to be able to access the new machine.
      *  Finally, to be able to push and pull this repository from github, add the .rsapub key to the github
         list of ssh keys at https://github.com/settings/ssh
2.  Set up the git profile on the new machine.  If it doesn't have git, this is a problem.  I'll figure
    this one out when I come across it.
      *  Copy over most of the mundane details from the ~/.gitconfig file on some other machine.
3.  Clone the repository to a reasonable placy, like `~/Projects/config_scripts/zsh`
      *  In the directory `~/Projects/config_scripts`, run `git clone git@github.com:dhollman/zsh_config_files.git zsh`
4.  Copy the directory `sample_zsh_local_dir` to the `~/.zsh` or something like that
5.  Copy `sample_local_zshrc` to `~/.zshrc`
6.  Run `git submoudle init` in the main `$ZSH_REPO` directory.
6.  Run `git submoudle update` in the main `$ZSH_REPO` directory.





