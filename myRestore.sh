find . -type f -name "*schema*" -print0 | xargs -0 -n1 -P4 sh -c 'cat $0 | mysql -u roy -proy pearch '
find . -type f -name "*data*" -print0 | xargs -0 -n1 -P4 sh -c 'cat $0 | mysql -u roy -proy pearch '
find . -type f -name "*view*" -print0 | xargs -0 -n1 -P4 sh -c 'cat $0 | mysql -u roy -proy pearch '
