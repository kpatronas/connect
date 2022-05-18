# connect
A simple connection manager written in bash

## What connect does?
Connect is a simple and clutter free connection manager for bash which allows you in a single command to open selected terminals, remote desktop connections, web browsers or whatever want, the whole configuration takes place in two text files.

## Configuring connect
When you first time run connect.sh will create the following two files if not exist
```
~/.connect/ext_vars.cfg
~/.connect/inventory.csv
```

### ext_vars.cfg 
This file contains variables that can be used for substitution in the inventory.csv file, the contents must be in the following form
variable_name=variable_value.

You can use whatever variable names you want!

```
ssh_username=my_username
win_prd_username=my_win_username
win_prd_password=my_win_username_password
win_prd_domain=my_domain
```

### inventory.csv
This file contains the hosts, a tag named environment that fit your needs, a notes field and the command to be executed when you select those hosts

```
host1;production_env;"A simple note";gnome-terminal -- ssh username@host1
```

Explaination
```
host1                                <-- a name we gave
production_env                       <-- a production name we gave
"A simple note"                      <-- a note we gave
gnome-terminal -- ssh username@host1 <-- This is the command that will be executed
```
