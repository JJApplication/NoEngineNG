#!/bin/bash

acme=~/.acme.sh
exe="$acme/acme.sh"
echo "停止Traefik使用acme模拟80端口"

pid=$(ps ax|grep Traefik|grep -v grep|awk '{print $1}')
if [ -n "$pid" ];then
  echo "Traefik PID: $pid"
  kill "$pid"
fi

echo "申请renj.io证书"
$exe --issue \
        -d renj.io \
        -d me.renj.io \
        -d dev.renj.io \
        -d service.renj.io \
        -d blog.renj.io  \
        -d x.renj.io \
        -d pkg.renj.io \
        --debug --standalone --force

# 会生成到当前目录下的renj.io_ecc
cd /root/.acme.sh/
res=$(ls | grep renj.io_ecc)
echo "生成目录: $res"
if [ -z "$res" ];then
        echo "未找到证书目录"
        exit 0
fi

echo "开始刷新证书文件"
cp  "/root/.acme.sh/$res/"* /renj.io/ssl

echo "申请jjapp.dev证书"
#domain jjapp.dev
$exe --issue -d jjapp.dev --debug --standalone --force
cd /root/.acme.sh/
res=$(ls | grep jjapp*_ecc)
echo "生成目录: $res"
if [ -z "$res" ];then
        echo "未找到证书目录"
        exit 0
fi

echo "开始刷新证书文件"
cp  "/root/.acme.sh/$res/"* /renj.io/ssl2
echo "完成"

echo "重命名证书文件"
cd /renj.io/ssl
mv *.key ssl.key

cd /renj.io/ssl2
mv *.key ssl.key