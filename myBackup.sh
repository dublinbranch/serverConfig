#!/bin/bash
user="root"
#pass="-p blablabla"
pass=""
host="localhost"
#verbose mode
#set -x

dat=$(date +%Y-%m-%d_%H-%M)
path="/srv/backup/mysql/$dat"
#silently create a new folder if needed
mkdir -p "$path"

for db in       i6927493_wp1 ingsm2023 fabenefa_wp505 magiskGestionale magiskAuxiliary mysql SCCE_Common SCCE_Optimization turboProp ; do
  tables=$(mysql -u $user $pass -h $host --batch -N -e "select table_name from information_schema.tables where table_type='BASE TABLE' and table_schema='$db';")
  views=$(mysql -u $user $pass -h $host --batch -N -e "select table_name from information_schema.tables where table_type='VIEW' and table_schema='$db';")

  #events
  #echo "events-$db"
  mysqldump -u $user $pass -h $host --no-tablespaces --no-create-db --no-create-info --no-data --events --routines --triggers --skip-opt $db > $path/$db.events.sql

  # backup all items as separate files
  for table in $tables; do
    #echo "table-$db.$table"
    mysqldump -u $user $pass -h $host --no-tablespaces --single-transaction --no-data --opt --skip-add-drop-table $db $table > $path/$db.$table.schema.sql
  done

  for table in $tables; do
    #echo "table-$db.$table"
    mysqldump -u $user $pass -h $host --no-tablespaces --single-transaction --no-create-info --extended-insert --quick --set-charset --skip-add-drop-table $db $table | xz -6 -T 4 > $path/$db.$table.data.sql.xz
  done

  for view in $views; do
    #echo "view-$db.$view"
    mysqldump -u $user $pass -h $host --no-tablespaces --single-transaction --opt --skip-add-drop-table $db $view > $path/$db.$view.view.sql
  done

done

#now copy on OVH ftp as a backup, which is SLOOOOW
rsync --ignore-existing --delete -rz --inplace /srv/backup/mysql    /mnt/ovhBackup/

find /srv/backup/mysql/ -mtime +5 -delete
