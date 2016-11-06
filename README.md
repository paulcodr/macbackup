# What
This shell script tars each folder in your Mac's home directory into a tar file. Useful when you need to switch out your old Mac and only a USB stick is available for copying files between old and new Mac. 


# Why
At work I had to swap out my work issued Macbook laptop twice in a month. It was a pain as I only had a 16G USB stick available for file transfer. Time Machine nor Migration Assistant was an option.

During the switchout, much of time was spent waiting for file transfer between   old-Mac --> USB-stick --> new-Mac. 

When you are copying many thousands of small files between storage devices (ex: Mac's internal storage and a USB stick), you can save time by tarring a folder into a tar file and copying the tar file over.


# Who
Anyone who needs to swap out Macs but Migration Assistant or Time Machine backup is not available. This script would be especially useful for those who need to manage multiple macOS computers.


# How
This script tars each folder in your home directory, including ~/.ssh/. It also checks for exported bookmarks file from browsers, pauses and gives user a chance to export bookmarks. Note when you use 'compress' command on a folder in macOS's Finder, it puts the files into a big file and zips it up. Depending on the CPU, this may not be helpful. So I use tar command without compression option.


# Copying files with and without tarring first.
Ran a test with my Documents folder.
It's 12G in size and has about 4400 files, mostly small text files but some large files also.

## Without tarring
When I tested copying the Documents folder weighting at 12G to a USB stick, it took almost 30 minutes to copy over 8G of data. I cut the test short.

## With tarring
Tarring folder took about 1 min 29 sec.
Copying over the 12G tar file to the USB stick took 28 minutes.


# Requirements
## Storage space on old Mac
You will need about half of the storage space free to run this script.

## USB drive partition
In case you are using a USB stick to copy files between 2 different Macs, make sure the USB drive is partitioned with 'Mac OS Extended (Journaled)' or ExFAT. DO not use MS-DOS (FAT) partitioned USB drive. MS-DOS FAT formatted drive cannot store files bigger than 4G.


# What folders are tarred by the script
In your macOS's home directory are these folders that you normally would want to copy to your new Mac.
Desktop
Documents
Downloads
Library \*
Movies
Music
Pictures
Public \*
Sites \*


# How to run script

> In this example, the script was executed on Nov 5, 2016, hence files/folder name is created with '\*\_2016_11_05'.

1. Open Terminal. Download the script -> make it executable -> run the script.

  ```
  cd ~/Downloads    
  curl -O https://raw.githubusercontent.com/paulcodr/macbackup/master/macbackup.sh
  chmod 750 ~/Downloads/macbackup.sh
  ~/Downloads/macbackup.sh
  ```
1. The script searches for exported bookmark files from browsers using file names commonly used by Chrome/Firefox/Safari in Documents and Desktop folders (but not the subfolders) of your home directory. If you forgot to export browser bookmarks, answer n to exit script, and export the bookmarks from your browsers. And rerun the script.

  ```
  ~/Downloads/macbackup.sh
  ```
1. Newly created tar files will be all in ~/Desktop/backup_2016_11_05/
1. Copy tar files to the new laptop, using USB stick or whatever other method.


# After copying tar files to new Mac

> On new Mac, I recommend copying the tar files to **~/Downloads/inbox/** or something like it. Even if a mistake is made while extracting the tar files, you won't end up with new files mixed up with other files in wrong directory.

## Extract the tar files
Follow 1 of the following 2 steps to extract the tar on the new mac

* In Finder: *all done in GUI environment of Finder*
  * Go to ~/Downloads/inbox
  * Double click on the .tar file to extract it. 
  * If the tar file is named Documents_backup_2016_11_05.tar, folder Documents_backup_2016_11_05 will be created & files will be extracted to that file.
* In Terminal: *all done in CLI environment in Terminal*
  * When extracting the tar files in terminal, the destination folder will NOT be created for you. For this reason, you will need to create the destination directory yourself.
  * In ~/Downloads/inbox, **create a directory (ex: Documents_backup_2016_11_05) to hold extracted files**. Avoid creating 'Documents', but use something like 'Documents-restore' to minimize confusion.
  ```
  cd ~/Downloads/inbox
  mkdir Documents_backup_2016_11_05   
  ```  
  * Extract the tar, while specifying the destination direction with -C  (capital letter C):
    
      ```
      tar -xf Documents_backup_2016_11_05.tar -C Documents_backup_2016_11_05
      ```
    
  * The files will be extracted into the directory Documents_backup_2016_11_05/.
  

## After extracting tar
Move extracted files into appropriate folders, such as Documents, Pictures, etc.


END
