# RSync

```shell
rsync -aHhP --numeric-ids --delete /home/neotech/phpmyadmin/ root@192.168.137.37:/home/neotech/phpmyadmin
```

```
-a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
-r, --recursive             recurse into directories
-l, --links                 copy symlinks as symlinks
-p, --perms                 preserve permissions
-t, --times                 preserve modification times
-g, --group                 preserve group
-o, --owner                 preserve owner (super-user only)

-H, --hard-links            preserve hard links
-h, --human-readable        output numbers in a human-readable format
-P                          same as --partial --progress
--partial                   keep partially transferred files
--progress                  show progress during transfer

--delete                    delete extraneous files from dest dirs
```
