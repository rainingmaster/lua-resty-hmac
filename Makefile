PREFIX		?= /usr/local/openresty
LUA_LIB_DIR	?= $(PREFIX)/lualib
INSTALL		?= install
VALGRIND	?= 0
CHECK_LEAK	?= 0
MODULES		?=

.PHONY: all test install

all:

install: all
	$(INSTALL) -d $(DESTDIR)$(LUA_LIB_DIR)/resty
	$(INSTALL) lib/resty/*.lua $(DESTDIR)$(LUA_LIB_DIR)/resty

test: install
	LUA_PATH="$(DESTDIR)$(LUA_LIB_DIR)/?.lua;;" TEST_NGINX_USE_VALGRIND=$(VALGRIND) TEST_NGINX_CHECK_LEAK=$(CHECK_LEAK) TEST_NGINX_LOAD_MODULES="$(MODULES)" prove -I../test-nginx/lib -r t
