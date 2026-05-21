CC := gcc
TARGETS := T4 T5

MYSQL_CFLAGS := $(shell mysql_config --cflags 2>/dev/null)
MYSQL_LIBS := $(shell mysql_config --libs 2>/dev/null)

ifeq ($(strip $(MYSQL_CFLAGS) $(MYSQL_LIBS)),)
MYSQL_CFLAGS := $(shell mariadb_config --cflags 2>/dev/null)
MYSQL_LIBS := $(shell mariadb_config --libs 2>/dev/null)
endif

ifeq ($(strip $(MYSQL_CFLAGS)),)
MYSQL_CFLAGS := -I/usr/include/mysql
endif

ifeq ($(strip $(MYSQL_LIBS)),)
MYSQL_LIBS := -L/usr/lib/x86_64-linux-gnu -lmysqlclient
endif

all: check-env $(TARGETS)

check-env:
	@test -f /usr/include/mysql/mysql.h || { echo "MySQL header not found: /usr/include/mysql/mysql.h"; exit 1; }
	@test -e /usr/lib/x86_64-linux-gnu/libmysqlclient.so || { echo "MySQL client library not found: /usr/lib/x86_64-linux-gnu/libmysqlclient.so"; exit 1; }

T4: T4.c
	$(CC) T4.c -o T4 $(MYSQL_CFLAGS) $(MYSQL_LIBS)

T5: T5.c
	$(CC) T5.c -o T5 $(MYSQL_CFLAGS) $(MYSQL_LIBS)

clean:
	rm -f $(TARGETS)

.PHONY: all check-env clean
