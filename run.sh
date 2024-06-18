#!/usr/bin/env bash

# docker openresty
# 不再使用本地编译的nginx二进制

APP_ROOT=/renj.io/app
NGINX_CONF=/renj.io/app/NoEngine/conf/nginx.conf
NGINX_CONFS=/renj.io/app/NoEngine/conf.d
NGINX_APP=/renj.io/app/NoEngine
NGINX_LOG=/renj.io/log/NoEngine
NGINX_LUA=/renj.io/app/NoEngine/lua
NGINX_SSL=/renj.io/ssl
NGINX_CACHE=/renj.io/cache/nginx
NGINX_CHALLENGE=/renj.io/.well-known

#需要暴露本机的端口给nginx
docker run --network host -v ${NGINX_CONFS}:/etc/nginx/conf.d \
-v ${APP_ROOT}:/renj.io/app \
-v ${NGINX_CONF}:/usr/local/openresty/nginx/conf/nginx.conf \
-v ${NGINX_APP}:/app \
-v ${NGINX_SSL}:/renj.io/ssl \
-v ${NGINX_LUA}:/app/lua \
-v ${NGINX_LOG}:/var/nginx/log \
-v ${NGINX_CACHE}:/var/nginx/cache \
-v ${NGINX_CHALLENGE}:/renj.io/.well-known \
-p 80:80 \
openresty/openresty