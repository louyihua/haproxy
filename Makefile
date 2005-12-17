CC = gcc
LD = gcc

# This is for Linux 2.4 with netfilter
COPTS.linux24 = -O2 -DNETFILTER
LIBS.linux24 =

# This is for Linux 2.2
COPTS.linux22 = -O2 -DUSE_GETSOCKNAME
LIBS.linux22 =

# This is for Solaris 8
COPTS.solaris = -O2 -fomit-frame-pointer -DSOLARIS -DHAVE_STRLCPY
LIBS.solaris = -lnsl -lsocket

# This is for OpenBSD 3.0
COPTS.openbsd = -O2 -DHAVE_STRLCPY
LIBS.openbsd =

# Select target OS. TARGET must match a system for which COPTS and LIBS are
# correctly defined above.
TARGET = linux24
#TARGET = linux22
#TARGET = solaris
#TARGET = openbsd

#DEBUG =
DEBUG = -g

COPTS=$(COPTS.$(TARGET))
LIBS=$(LIBS.$(TARGET))

# - use -DSTATTIME=0 to disable statistics, else specify an interval in
#   milliseconds.
# - use -DTRANSPARENT to compile with transparent proxy support.
CFLAGS = -Wall $(COPTS) $(DEBUG) -DSTATTIME=0 -DTRANSPARENT
LDFLAGS = -g

all: haproxy

haproxy: haproxy.o
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o:	%.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -vf *.[oas] *~ core haproxy test nohup.out gmon.out
