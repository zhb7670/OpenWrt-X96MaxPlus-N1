#!/bin/bash
#=====================================================================================
# OpenWrt-X96MaxPlus-N1
# diy-part1.sh  —  feeds update 之前执行
#
# 基线：https://github.com/ophub/amlogic-s9xxx-openwrt
#       config/lede_master/diy-part1.sh  （原样保留其所修编译坑）
# 源码：https://github.com/coolsnowwolf/lede  branch: master
#
# ⚠️ 执行时机（.github/workflows/build-openwrt-system-image.yml "Load custom feeds"）：
#       cp config/lede_master/feeds.conf.default -> openwrt/feeds.conf.default
#       cd openwrt/ && ./config/lede_master/diy-part1.sh
#       ./scripts/feeds update -a
#=====================================================================================

echo "[diy-part1] PWD: $(pwd)"

#-------------------------------------------------------------------------------------
# 0. 打印 feed 配置（排错用）
#-------------------------------------------------------------------------------------
if [[ -f "feeds.conf.default" ]]; then
    echo "[diy-part1] ===== feeds.conf.default ====="
    cat feeds.conf.default
    echo "[diy-part1] ==============================="
else
    echo "[diy-part1] WARNING: feeds.conf.default not found!"
fi

# 幂等兜底：确保 small-package 存在（正常情况下已由 feeds.conf.default 带入）
if [[ -f "feeds.conf.default" ]]; then
    grep -q "kenzok8/small-package" feeds.conf.default || {
        echo "[diy-part1] Appending missing small-package feed."
        echo "src-git small https://github.com/kenzok8/small-package.git" >> feeds.conf.default
    }
fi

#-------------------------------------------------------------------------------------
# 1. PassWall 依赖包（必须在 feeds update 前 clone）
#    保留 ophub 原始配置，不改动
#-------------------------------------------------------------------------------------
echo "[diy-part1] Cloning openwrt-passwall-packages..."
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages || {
    echo "[diy-part1] ERROR: failed to clone passwall-packages"
    exit 1
}

#-------------------------------------------------------------------------------------
# 2. MosDNS v5 + v2ray-geodata（保留 ophub 原始配置）
#-------------------------------------------------------------------------------------
echo "[diy-part1] Cloning luci-app-mosdns + v2ray-geodata..."
rm -rf feeds/packages/net/v2ray-geodata
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/mosdns || {
    echo "[diy-part1] ERROR: failed to clone luci-app-mosdns"
    exit 1
}
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata || {
    echo "[diy-part1] ERROR: failed to clone v2ray-geodata"
    exit 1
}

#-------------------------------------------------------------------------------------
# 3. 其他依赖（备选，默认关闭）
#-------------------------------------------------------------------------------------
# ssr-plus 依赖包 - helloworld 源（已在 feeds.conf.default 中挂载，此处兜底）
# git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

# 移除不需要的包
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

echo "[diy-part1] Done."
