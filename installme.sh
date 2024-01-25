#at one point or another I will use all of that
#-n means non interactive
zypper -n in sshfs moreutils strace vnstat sysstat iotop htop boost-devel bash-completion
zypper -n in autossh tree tcpdump curlftpfs netcat gnu_parallel

# skip suggested as will install half gnome enviroment for some reason
zypper in --no-recommends  perf


#only for server
#zypper -n in net-snmp net-snmp-devel munin-node percona-toolkit

#to be able to replicate an ssh command on multiple machine, remember the two config file so is not UUUGLY!
#Put those in your home .Xresources  and csshconf
zypper -n in clusterssh

rcvnstatd start
chkconfig vnstatd on

rcsnmpd start
chkconfig snmpd on
