# connect

A simple connection manager written in bash

## How easy is it to open 3 ssh terminals 1 rdp connection and 1 web-browser at the same time?

Very easy!

Assuming that we have already configured our settings:

To list connections

```
$ ./connect.sh
Host       Env        Notes
host1      prod       "Host1 ssh connection"
host2      prod       "Host1 ssh connection"
host3      test       "Host1 ssh connection"
host4      prod       "Host4 rdp connection"
vcn-webui  prod       "vcenter1 web ui"
```

To list connections filtered by environment contain "prod" (you can apply whatever regex you want)

```
$ ./connect.sh -e prod
Host       Env        Notes
host1      prod       "Host1 ssh connection"
host2      prod       "Host1 ssh connection"
host4      prod       "Host4 rdp connection"
vcn-webui  prod       "vcenter1 web ui"
```

To list connections filtered by environment contain "prod" and host starts with "h"

```
./connect.sh -e prod -h ^h
Host       Env        Notes
host1      prod       "Host1 ssh connection"
host2      prod       "Host1 ssh connection"
host4      prod       "Host4 rdp connection"
```

To list connections filtered by environment contain "prod" and host starts with "h"

```
./connect.sh -e prod -h ^h
Host       Env        Notes
host1      prod       "Host1 ssh connection"
host2      prod       "Host1 ssh connection"
host4      prod       "Host4 rdp connection"
```

To start connections filtered by environment contain "prod" and host starts with "h"

```
./connect.sh -e prod -h ^h -c
Host       Env        Notes
host1      prod       "Host1 ssh connection"
host2      prod       "Host1 ssh connection"
host4      prod       "Host4 rdp connection"
```

If inventory.csv is configured correctly it will open two ssh connections and one rdp connection!

## What connect does?

Connect is a simple and clutter free connection manager for bash which allows you in a single command to open selected ssh, remote desktop connections, web browsers or whatever you want. The whole configuration takes place in two text files.

## Configuring connect

When you first time run connect.sh will create the following two files if not exist.

```
~/.connect/ext_vars.cfg
~/.connect/inventory.csv
```

### ext_vars.cfg

This file contains variables that can be used for substitution in the inventory.csv file, the contents must be in the following form:

variable_name=variable_value.

You can use whatever variable names you want!

```
ssh_username=my_username
win_prd_username=my_win_username
win_prd_password=my_win_username_password
win_prd_domain=my_domain
```

### inventory.csv

This file contains the hosts, a tag named environment that fit your needs, a notes field and the command to be executed when you select those hosts.

#### A simple example

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

#### A less simple example

```
host2;test_env;"Another simple note";gnome-terminal -- ssh $ssh_username@host2
```

Explanation:

```
host2                                     <-- a name we gave
test_env                                  <-- a production name we gave
"Another simple note"                     <-- a note we gave
gnome-terminal -- ssh $ssh_username@host1 <-- This is the command that will be executed, $ssh_username will take its value from ext_vars.cfg ssh_username variable.
```

#### More examples

```
host1;production_env;"A simple note";gnome-terminal -- ssh username@host1
host2;test_env;"Another simple note";gnome-terminal -- ssh $ssh_username@host2
host3;production_env;"A windows host";xfreerdp /d:$win_prd_domain /u:$win_prd_username /v:127.0.0.1:33891 /p:$win_prd_password
web_page_vcenter;production_env;"vcenter webui";"/usr/bin/firefox https://vcenter1:443"
```

We can configure almost everything that can be selected and executed.
