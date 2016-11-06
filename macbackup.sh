#!/bin/bash
# Paul Chu
# OS X backup tool
# Tars each folder in home folder, including ~/.ssh
# When untarred, the files will not include the full file path.

# Migration Tool and Time Machine are best options for migrating to another Mac.
# However sometimes those are not available. Often in corporate setting.
# And when you are migrating between 2 Macs, you are copyin lots of little files
# using a USB stick/drive.

# TO DO
# Rename all .hidden_file.tar to hidden_file.tar


## variables
#_folders=( "Desktop" "Documents" "Downloads" "Movies" "Music" "Pictures" "Public" ".ssh" )
_folders=( "Documents" )
_today=`date +%Y_%m_%d`
_tag="backup_${_today}"
_script=`basename $BASH_SOURCE`
_bookmarks_chrome=0
_bookmarks_firefox=0
_bookmarks_safari=0
declare _bookmarks_total

function func_bookmarks(){
_bookmarks_chrome=`find ~/Documents ~/Desktop -maxdepth 1 -type f -name bookmarks_*_*_*.html | wc -l`
_bookmarks_firefox=`find ~/Documents ~/Desktop -maxdepth 1 -type f -name bookmarks.html | wc -l`
_bookmarks_safari=`find ~/Documents ~/Desktop   -maxdepth 1 -type f -name "Safari Bookmarks*" | wc -l`

_bookmarks_total=$(($_bookmarks_chrome + $_bookmarks_firefox + $_bookmarks_safari))

echo -e "\n####################"
if [ $_bookmarks_chrome == 0 ]; then
 echo "# It seems there is no exported backup of bookmarks from Chrome."
fi

if [ $_bookmarks_firefox == 0 ]; then
 echo "# It seems there is no exported backup of bookmarks from Firefox."
fi

if [ $_bookmarks_safari == 0 ]; then
 echo "# It seems there is no exported backup of bookmarks from Safari."
fi


if [ $_bookmarks_total != 0 ]; then
 echo "# Found $_bookmarks_total exported bookmarks from Chrome/Firefox/Safari"
 echo "# in ~/Documents and ~/Desktop."
 else
 echo "# It seems there is no exported backup of bookmarks from any web browser."
fi

echo -e "\n# It is strongly recommended that you export bookmarks from your web browsers"
echo "# to Desktop or Documents folder before running this script."
echo "# If required, you can exit this script ($_script), export bookmarks, and rerun this script."
echo -e "####################\n"

while true; do
    read -p "Do you wish to proceed with tarring the folders?  (y or n) " yn
    case $yn in
        [Yy]* ) echo "# Starting tarring operation."; break;;
        [Nn]* ) echo -e "# Exiting script.\n"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
}


function func_tar(){
# Tar folders
#echo -e "\n###  When prompted for password, enter your Mac's root password.  ###"
mkdir ~/Desktop/$_tag 2> /dev/null
echo -e "\nAll tar files are stored in ~/Desktop/$_tag/\n"
for _i in "${_folders[@]}"
do
  tar --exclude="*_${_tag}.tar" -cf ~/Desktop/$_tag/${_i}_${_tag}.tar -C ~/${_i} . && echo -e "Finished tarring ~/${_i} --> ${_i}_${_tag}.tar\n "
done
chown $USER: ~/Desktop/$_tag/*.tar
}


function func_rename(){
# Rename .ssh_*** to ssh_***chu
find ~/Desktop/$_tag -maxdepth 1 -type f -name ".ssh_${_tag}.tar" -execdir mv -f {} ssh_${_tag}.tar \;
echo "Renamed .ssh_${_tag}.tar --> ssh_${_tag}.tar"
}


function func_list(){
  echo -e "\n####################"
  echo "# Sizes of the tar files:"
  echo "####################"
  ls -lh ~/Desktop/$_tag/*${_tag}.tar | awk '{print $5,$9}'
  chown $USER: ~/Desktop/*.tar
}

function func_end() {
  echo -e "\n###   On Your New Mac   #################################################"
  echo "# 1. Copy all files ending with     ${_tag}.tar   from your"
  echo "#    Mac's  ~/Desktop/  to your new Mac."
  echo "# 2. Recommend copying the files into   ~/Desktop/2restore/   on your new Mac."
  echo "# 3. Untar  ssh_${_tag}.tar  and MOVE the content into   ~/.ssh/ on the new Mac. "
  echo "#    These are SSH key files."
  echo "# 4. Untar other ***${_tag}.tar files and MOVE the content into appropriate folders."
  echo "#####################################################################"

  echo -e "\n###   END   #########################################################\n"
}


func_bookmarks
func_tar
func_rename
func_list
func_end
