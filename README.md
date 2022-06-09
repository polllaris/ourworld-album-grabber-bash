# ourWorld Album Grabber (bash)

## A bash script for mac os that will read the games cache directory and move downloaded album photos to a temporary directory where you can then save them.

### Goal
The goal of this script is to get back any photos that were loaded in the past with the game client
and give players the chance to get back photos that they may not have saved prior to the game shutting down,
due to adobe air downloading all album photos for caching and not just a single persons: that means if one person
didn't load their album then someone else may have and the photos may be recoverable through the computer of that other person.

#### Simple Usage
Open a terminal, paste in the following command and hit enter:

```
curl https://raw.githubusercontent.com/polllaris/ourworld-album-grabber-bash/albumgrab.sh | bash
```

The script will search for your games netcache directory and if it's not found then it will exit, otherwise...
the script will show you an introduction screen explaining what it does and you can press enter to start it,
if successful you will be brought to a temporary directory with your album photos which you can move elsewhere to keep.

