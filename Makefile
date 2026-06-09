#
# Makefile for macfanctl
#
# Mikael Strom, August 2010
#

CC = gcc
CFLAGS = -Wall
SBIN_DIR = $(DESTDIR)/usr/sbin
ETC_DIR = $(DESTDIR)/etc
SERVICE_DIR = $(ETC_DIR)/systemd/system

all: macfanctld

macfanctld: macfanctl.c control.c config.c control.h config.h
	$(CC) $(CFLAGS) macfanctl.c control.c config.c -o macfanctld 

clean:
	dh_testdir
	dh_clean
	rm -rf *.o macfanctld

install:
	dh_installdirs
	chmod +x macfanctld
	cp macfanctld $(SBIN_DIR)
	cp macfanctl.conf $(ETC_DIR)
	cp macfanctld.service $(SERVICE_DIR)
	systemctl daemon-reload
	systemctl enable --now macfanctld.service

uninstall:
	rm $(SBIN_DIR)/macfanctld $(INITD_DIR)/macfanctl $(ETC_DIR)/macfanctl.conf $(SERVICE_DIR)/macfanctld.service

