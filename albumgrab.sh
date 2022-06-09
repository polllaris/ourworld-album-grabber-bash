#!/usr/bin/env bash
# Author: Polllaris AKA Jess
# This script was written and intended for OS X users to
# be able to paste into their terminal to be able to retrieve
# their own and other peoples album photos from their ourworld netcache.
#
# This script was written on a modern distribution GNU/Linux with the specifics
# and design in mind for doing this on OS X such as using sips for image resolution.
#
# As I do not own a machine with OS X on it I needed someone
# else to test what I had written and go from there.
#
# Due to issues that had arisen on OS X the design of this script has changed
# multiple times and is not as clean as originally intended, none the less...
# this script does exactly what it set out to do in a way appropriate to OS X.
#
# Special thanks to Natassia for contributing six hours of her own time and using
# her mac, inputing commands into her terminal, sending screenshots and being patient,
# this would not have been completed in this time frame without her.

function album_grabber_main() {

	tmpdir_name="tmp-$(date +%s)"
	tmpdir_path="/tmp/$tmpdir_name"
	# the actual path with escaped spaces didn't nice with things for some reason
	cachedir_path=$(find $HOME -type d -name "*netcache*" | grep "ourWorld")
	fileexplorer_command="open"
	echo "searching ourworld for netcache directory"
	if [[ $cachedir_path == "" ]]; then
		echo "netcache directory not found"
		exit
	fi
	echo "found ourworld netcache directory at $cachedir_path"
	echo
	echo "Welcome to AlbumGrab (shell), a small script made to read"
	echo "album photos from the games cache directory. If you have"
	echo "never deleted your cache directory then every album photo that"
	echo "you've loaded with the desktop client will be recoverable"
	echo
	echo "NOTE: You will be able to recover the album photos of anyone elses albums"
	echo "that you have loaded with your game client. That being said if you are"
	echo "unable to recover your own: you can possibly give this utility to someone"
	echo "who has loaded your photos and recover through them. Happy Recovering ~ Jess"
	echo
	echo "Press enter to continue..."
	read

	mkdir $tmpdir_path
	echo "created directory $tmpdir_path"
	if [ ! -d "$cachedir_path" ]; then
		echo "unable to find the netcache directory"
		exit
	fi
	printf "%-34s %-34s\n" "orig_name" "copy_name"
	for filename in $(ls "$cachedir_path"); do
		filepath="$cachedir_path/$filename"
		# check if filepath is a directory
		if [ -d "$filepath" ]; then
			echo $filepath is a directory
			continue
		fi
		copypath="$tmpdir_path/$filename.jpg"
		# check if the file is a jpeg by getting and checking its mimetype
		mimetype=$(file "$filepath" --mime-type | cut -d ":" -f 2 | cut -d " " -f 2)
		if [[ ! $mimetype == "image/jpeg" ]]; then
			continue
		fi
		# I just didn't feel like fighting with formatting as I am not on a mac to test it myself
		pixel_width=$(sips -g pixelWidth -g pixelHeight "$filepath" | grep "Width" | cut -d " " -f 4)
		pixel_height=$(sips -g pixelHeight -g pixelWidth "$filepath" | grep "Height" | cut -d " " -f 4)
		# check if the resolution of the image matches that of an album photo
		if [[ ! "$pixel_width" == "633" ]] || [[ ! "$pixel_height" == "475" ]]; then
			continue
		fi
		cp "$filepath" "$copypath"
		printf "%-34s %-34s\n" $filename $(basename $copypath)
	done
	echo
	echo "A temporary directory has been created and album photos"
	echo "from the cache have been moved to it. A file explorer window"
	echo "will popup and bring you to it where you can move them out to keep"
	echo
	echo "This script was brought to you and made by... Polllaris aka Jess"
	echo "and built on/around the mac of Natassia, special thanks to her as"
	echo "she has contributed six hours of her own time to helping with testing"
	echo "this as it was being made."

	$fileexplorer_command $tmpdir_path
}

album_grabber_main


