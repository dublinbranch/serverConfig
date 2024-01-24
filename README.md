# serverConfig
some common things to prime a new suse server, you can upload wherever, even in the same machine


# firewall and change ssh port
```
zypper in firewalld
rcfirewalld start
chkconfig firewalld on
firewall-cmd --zone=public --permanent --add-port=1022/tcp
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
```
New version will use 
`nft list ruleset`
To check if is working istead of iptables


# SSH KEY! and disable password login 

```
ssh-keygen

### On your machine
### cat ~/.ssh/id_rsa.pub 

vi /root/.ssh/authorized_keys

### DO NOT DISCONNECT! Open another session and check if asking for the password or not
write those 2 into the file

localhost:~ # cat /etc/ssh/sshd_config.d/conf.conf
PasswordAuthentication no
ChallengeResponseAuthentication no

rcsshd restart 
and reconnect 
```

# SSH client only
```
We still have a good number of older machine who still use older now deprecated ssh encription scheme

https://confluence.atlassian.com/bitbucketserverkb/ssh-rsa-key-rejected-with-message-no-mutual-signature-algorithm-1026057701.html

Add this in /etc/ssh/ssh_config

PubkeyAcceptedKeyTypes +ssh-rsa

Also add to connect on the non standard port the 

host techadsmedia.com
        Port 1022
host s14.techadsmedia.com
        Port 1022
host s16.techadsmedia.com
        Port 1022
host s20.techadsmedia.com
        Port 1022
host s18
        Port 1022
host s22.techadsmedia.com
        Port 1022
Finally the keep alive 

ServerAliveInterval 60



```
# set proper git usage and first repo
```
zypper in git vim
git config --global ubmodule.fetchJobs 10
git config --global --edit
#and configure your user
```
```
cd /etc
touch .gitignore
echo "ld.so.cache" >> .gitignore
echo "udev/*" >> .gitignore
echo "udev/*" >> .gitignore
echo "ssh/moduli" >> .gitignore


git init
git add *
git commit -a -m"init"
#create repo to push
```



# NO SWAP, this is a server, this is 2021 just buy more RAM
to check if is active something
 ```
swapon
 ```
to disable all
 ```
swapoff -a
 ```

# bashrc
```
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/bashrc" -O -> ~/.bashrc
```


# journald persistent
```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
echo "SystemMaxUse=10G" >> /etc/systemd/journald.conf
echo "Storage=persistent" >> /etc/systemd/journald.conf
systemctl restart systemd-journald.service
```

# common tooling
```
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/installme.sh" -O -> /tmp/installme.sh
chmod +x /tmp/installme.sh
/tmp/installme.sh
```

# mariadb 
```
if you are installing for your machine 
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/mariadbBase.sh" -O -> /tmp/mariadb.sh
chmod +x /tmp/mariadb.sh
/tmp/mariadb.sh


for server
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/mariadbServer.sh" -O -> /tmp/mariadb.sh
chmod +x /tmp/mariadb.sh
/tmp/mariadb.sh
```

### now create the first user if needed https://s22.trott.pw/dev_wiki/index.php?title=MySQL_Create_User

something like

```
CREATE ALWAYS BOTH! You have no idea which one php will decide to use!!!

CREATE USER 'roysXX'@'localhost' IDENTIFIED BY 'abc';
GRANT ALL PRIVILEGES ON *.* TO 'roysXX'@'localhost'  WITH GRANT OPTION;
flush privileges;


CREATE USER 'roysXX'@'127.0.0.1' IDENTIFIED BY 'abc';
GRANT ALL PRIVILEGES ON *.* TO 'roysXX'@'127.0.0.1'  WITH GRANT OPTION;
flush privileges;
```

# NGINX
Remember for a server to increase the worker and max open file (check the file for info)

# ephemeral port exaustion (TCP Port Lingering)
```
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
```
# php 7.4 (check if you have php installed, if so remove completely, script tested only for fresh install)
#this script will apply a patch so commit git!
```
cd /etc/
git commit -m"setup in progress"
git add *

# this also contain basic nginx
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/php74.sh" -O -> /tmp/php74.sh
chmod +x /tmp/php74.sh
/tmp/php74.sh
```

# create another user
```
useradd ivano.mercuri
mkdir /home/ivano.mercuri
chown ivano.mercuri:users /home/ivano.mercuri
usermod -g nginx ivano.mercuri
su ivano.mercuri
```
# FINAL NOTES
in case of failed patch use 
patch -p1 < /tmp/phpfpm.patch 
to see why is failing, maybe some update somewhere broke something...

# Munin
Please check the internal wiki (Munin-node) as is complex and interleaved a bit

# For desktop
balooctl --disable
