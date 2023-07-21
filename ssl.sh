#!/bin/bash

acme=~/.acme.sh
exe="$acme/acme.sh"
echo "停止NoEngine使用acme模拟80端口"

docker stop NoEngine
$exe --issue \
-d renj.io \
-d me.renj.io \
-d dev.renj.io \
-d service.renj.io \
-d blog.renj.io \
--debug --standalone --force

# 会生成到当前目录下的renj.io_ecc
res=$(ls | grep ecc)
echo "生成目录: $res"
if [ -z "$res" ];then
        echo "未找到证书目录"
        exit 0
fi

echo "开始刷新证书文件"
cp -Rf "$res/*" /renj.io/ssl