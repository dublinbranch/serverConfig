#qt need to be installed by itself

zypper in cmake git okteta clazy cmake binutils-gold mold
zypper in cpp11 gcc gcc11 gcc11-c++ gcc-c++

#In 99.99% is ok to use ld-gold instead of bfg, ATM I (Roy) the only problem is linking mariadb
rm /etc/alternatives/ld
ln -s /usr/bin/ld.gold /etc/alternatives/ld

#mold instead, faster but still some minor annoyances with valgrind in some cases use at your own risk
#remember to change the .pro to use it (normally put in the mkSpec.pri
# QMAKE_LFLAGS += -B /usr/bin/mold
zypper in mold

zypper in libcurl-devel jemalloc-devel libzip-devel libmaxminddb-devel libdw-devel libmariadb-devel boost-devel libxml++-devel

#boost version be sure to have at least the 71
