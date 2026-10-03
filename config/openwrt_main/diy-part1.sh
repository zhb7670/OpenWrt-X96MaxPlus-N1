#!/bin/bash
#=====================================================================================
# OpenWrt-X96MaxPlus-N1
# diy-part1.sh  —  feeds update 之前执行
#
# 上游参考：https://github.com/ophub/amlogic-s9xxx-openwrt
# 作用：追加/确认自定义 feed 源
#
# ⚠️ 本文件在 "Load custom feeds" 步骤执行：
#      cp config/openwrt_main/feeds.conf.default -> openwrt/feeds.conf.default
#      cd openwrt/ && ./diy-part1.sh
#      然后才 ./scripts/feeds update -a
#=====================================================================================

echo "[diy-part1] Working directory: $(pwd)"

# ---- 确认 feeds.conf.default 已生效 ----
if [[ -f "feeds.conf.default" ]]; then
    echo "[diy-part1] feeds.conf.default contents:"
    cat feeds.conf.default
else
    echo "[diy-part1] WARNING: feeds.conf.default not found!"
fi

# ---- 追加自定义 feed 源（如 feeds.conf.default 未包含时兜底）----
# 注：正常情况下 config/openwrt_main/feeds.conf.default 已覆盖上游文件，
#     这里只做幂等兜底，避免重复追加。
if [[ -f "feeds.conf.default" ]]; then
    grep -q "kenzok8/small-package" feeds.conf.default || \
        echo "src-git small https://github.com/kenzok8/small-package.git" >> feeds.conf.default
fi

# ---- 移除不必要的包（如需要，取消注释）----
# rm -rf package/utils/{ucode,fbtest}

echo "[diy-part1] Done."
