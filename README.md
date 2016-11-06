# What
This Shell script tars each folder in your Mac's home directory into a tar file. Useful when you need to switch out your old Mac and only a USB stick is available for copying files between old and new Mac. 


# Why
At work I had to swap out my work issued Macbook laptop twice in a month. It was a pain as I only had a 16G USB stick available for file transfer. Time Machine nor Migration Assistant was an option.

During the switchout, much of time was spent waiting for file transfer between   old-Mac --> USB-stick --> new-Mac. 

When you are copying many thousands of small files between storage devices (ex: Mac's internal storage and a USB stick), you can save time by tarring a folder into a tar file and copying the tar file over.


# Who
Anyone who needs to swap out Macs but Migration Assistant or Time Machine backup is not available. 


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


# USB drive partition
In case you are using a USB stick to copy files between 2 different Macs, make sure the USB drive is partitioned with 'Mac OS Extended (Journaled)' or ExFAT. DO not use MS-DOS (FAT) partitioned USB drive. MS-DOS FAT formatted drive cannot store files bigger than 4G.


# How To
Run the 
