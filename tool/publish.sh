#!/bin/bash
# Flutter pub.dev 一键发布脚本 (macOS + Clash 7897)
# 功能：清环境、切源、配代理、发布、自动切回镜像加速

set -e  # 任一步出错就退出

echo "================ 🔧 清理环境 ================"
killall -9 dart 2>/dev/null
unset PUB_HOSTED_URL
unset FLUTTER_STORAGE_BASE_URL
unset http_proxy
unset https_proxy
# rm -rf ~/.pub-cache

flutter clean

echo "================ 🎯 切官方源 ================"
export PUB_HOSTED_URL="https://pub.dev"

echo "================ 🌐 配置 Clash 代理(7897) ================"
export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897
export ALL_PROXY=socks5://127.0.0.1:7897

echo "================ ✅ 验证网络 ================"
curl ip.sb

echo "================ 🚀 开始发布 ================"
flutter pub publish --force

echo "================ ⚡ 切回清华镜像加速开发 ================"
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub"

echo "================ 🎉 发布完成！ ================"
