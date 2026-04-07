#!/usr/bin/env zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR%/tool}"

cd "$PROJECT_ROOT"

DEVICE_ID="$1"

if [[ -z "$DEVICE_ID" ]]; then
  DEVICE_ID="$(flutter devices | awk -F '•' '/ios/ && /simulator/ {gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2; exit}')"
fi

if [[ -z "$DEVICE_ID" ]]; then
  echo "未找到可用的 iOS 模拟器设备，请先在 Xcode 中创建/启动一个模拟器。"
  echo
  flutter devices
  exit 1
fi

echo "使用设备: $DEVICE_ID"
flutter run -t example/lib/main.dart -d "$DEVICE_ID"
