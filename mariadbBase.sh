zypper -n in mariadb mariadb-client mariadb-server mariadb-tools

systemctl start mariadb
#autostart
systemctl enable mariadb

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

echo "now setup the user to connect https://s22.trott.pw/dev_wiki/index.php?title=MySQL_Create_User"

