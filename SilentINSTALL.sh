#!/bin/bash
############################################################################
#
# NOTE: This script is distructive, it will change your dotfiles!
#
# This script does the following:
# 0) assumes that you are ray.
# 1) backs up your current dotfiles in ~/ray/dotfiles_old/
# 2) creates symlinks to ~/ray/dotfiles/
# 3) load specified bash_completion files
# 4) load crontab from ~/ray/dotfiles
############################################################################


############################################################################
#===========================================================================
# Set username - this is because cron runs job as root.
#===========================================================================
username="ray"

############################################################################
#===========================================================================
# Setup post commit hook
#===========================================================================
#echo "Symlinking hooks/post-commit"
#if [ -e ~/ray/.git/hooks/post-commit ]; then
#  echo ".git/hooks/post-commit already exists..."
#  echo "I will not symlink to ./hooks/post-commit"
#else
#  ln -s ~/ray/hooks/post-commit ~/ray/.git/hooks/post-commit
#fi
#
#echo "Done symlinking post-commit hook"
#echo " "


############################################################################
#===========================================================================
# Backup and symlink dotfiles
#===========================================================================
dir="ray/dotfiles"          # My dotfiles
dir_old="ray/dotfiles_old"  # Old dotfiles backup directory

## declare an array of files to backup
declare -a files=(".bashrc" \
                  ".bashrc_alias" \
                  ".vimrc" \
                  ".gvimrc")

echo "Moving old files into $dir_old/"
echo " "

## Change to home directory
cd

## now loop through the above array
for file in "${files[@]}"
do
  if [ -e $file ]; then
    mv $file ~/$dir_old/
  else
    echo "$file does not exist"
  fi
  
  echo "Creating symlink to $file in home directory."
  ln -s ~/$dir/$file ~/$file
done

## I have decided to not link the dot files from Dropbox.
## Firstly, they are now located at:
## Dropbox/linux_sync/dot_ssh/
## Dropbox/linux_sync/dot_vim/
##
## Secondly, I need to link the dot_ssh BEFORE I run this, since I need
## the ssh config files to get access to the repo.
## Then I need to link dot_vim AFTER I run this, and after I've set up
## gvim. So as you can see, this is no longer required.

### Linking to files in Dropbox
#dir="Dropbox/linux_sync"          # Other sync files
#declare -a files=(".ssh/config" \
#                  ".vim")
#
### now loop through the above array
#for file in "${files[@]}"
#do
#  if [ -e ~/$dir/$file ]; then
#    if [ -e $file ]; then
#      mv $file ~/$dir_old/
#    else
#      echo "$file does not exist"
#    fi
#    
#    echo "Creating symlink to $file in home directory."
#    ln -s ~/$dir/$file ~/$file
#  else
#    echo "~/$dir/$file does not exist. Perhaps you are not Ray."
#  fi
#done

echo "All dotfiles are loaded!"
echo " "

#############################################################################
##===========================================================================
## Load completion files
##===========================================================================
#OptionPrompt "Do you want to load completion files?"
#reply=`OptionRead`
#echo " "
#if test "$reply" != "y" -a "$reply" != "Y" ; then
#  echo "Completion files not loaded."
#else
#  ## For bin/rbackup
#  if [ -e /etc/bash_completion.d/rbackup ];
#  then
#    echo "/etc/bash_completion.d/rbackup exists."
#    echo "I will not load completion for bin/rbackup"
#  else
#    cp ~/ray/bin/completion/rbackup /etc/bash_completion.d/
#    echo "Loaded completion file for rbackup"
#  fi
#fi


#############################################################################
##===========================================================================
## Load crontab
##===========================================================================
#echo " "
#echo "Do you want to load Ray's crontab?"
#echo "See ~/ray/dotfiles/crontab_$USERNAME$HOSTNAME"
#echo "Your current crontab will be stored in"
#echo " "
#echo "    " $dir_old/
#echo " "
#echo " "
#
#OptionPrompt " Is this OK? [y/n -- default: n]"
#reply=`OptionRead`
#if test "$reply" != "y" -a "$reply" != "Y" ; then
#  echo "crontab not loaded."
#else
#  CRONFILE_BK="crontab_${USER}${HOSTNAME}_$(date +"%F")"
#  crontab -l > ~/$dir_old/$CRONFILE_BK
#  crontab ~/ray/dotfiles/crontab_$USERNAME$HOSTNAME
#  echo "Done... your previous crontab is stored in"
#  echo " "
#  echo "  " ~/$dir_old/$CRONFILE_BK
#fi


############################################################################
#echo " "
#echo "I finished!"
#echo "Please check that your userdata/bkdirs_usernamehostname" 
#echo "file is set properly"

