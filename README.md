# OpenWrt-X96MaxPlus-N1

专为 **X96 Max+ (Amlogic S905X3)** 与 **斐讯 N1 (Amlogic S905D)** 打造的持续维护 OpenWrt 固件项目。

> 理念继承自已归档的 [haiibo/OpenWrt](https://github.com/haiibo/OpenWrt) ARMv8 Plus，
> 但**不复制旧代码** —— 全面基于当前上游重新构建：
> 现代 OpenWrt + 当前稳定 Linux Kernel + 当前 LuCI + 当前插件源码。

[![Build](https://github.com/zhb7670/OpenWrt-X96MaxPlus-N1/actions/workflows/build.yml/badge.svg)](https://github.com/zhb7670/OpenWrt-X96MaxPlus-N1/actions/workflows/build.yml)

---

## 一、支持的设备

本项目**只做这两个硬件系列**，其他 Amlogic 盒子一律不构建。

| 设备 | SoC | 说明 |
|---|---|---|
| **X96 Max+** | Amlogic S905X3 | 含各网卡/WiFi 变体 |
| **斐讯 N1** | Amlogic S905D | 标准版 / DMA-thresh 版 |

## 二、硬件矩阵（来自 OPHUB model database，非猜测）

### X96 Max+ / S905X3 全部变体

| ID | 型号 | DTB | 网卡 | WiFi | 官方BUILD |
|---|---|---|---|---|---|
| 501 | X96-Max+_100Mb | `meson-sm1-x96-max-plus-100m.dtb` | **1Gb** | rtl8822cs | ✅ |
| 502 | X96-Max+_1GB | `meson-sm1-x96-max-plus.dtb` | 1Gb | rtl8822cs | — |
| 503 | X96-Max+(OverClock) | `meson-sm1-x96-max-plus-oc.dtb` | 1Gb | rtl8822cs | — |
| 504 | X96-Max+(IP1001M) | `meson-sm1-x96-max-plus-ip1001m.dtb` | 1Gb(IP1001M) | brcm4354 | — |
| 505 | X96-Max+_A100 | `meson-sm1-x96-max-plus-a100.dtb` | 100Mb | AM7256 | — |
| 506 | X96-Max+_2101 | `meson-sm1-x96-max-plus-2101.dtb` | 1Gb(JL2xx1) | WiFi/BT | — |
| 507 | X96-Max+Q1 | `meson-sm1-x96-max-plus-q1.dtb` | 100Mb | WiFi | — |
| 508 | X96-Max+Q2 | `meson-sm1-x96-max-plus-q2.dtb` | 1Gb | qca9377 | — |
| 509 | X96-Air-1Gb | `meson-sm1-x96-air-gbit.dtb` | 1Gb | WiFi | — |
| 510 | X96-Air-100Mb | `meson-sm1-x96-air.dtb` | 100Mb | WiFi | — |

> ⚠️ **重要**：`X96-Max+_100Mb` 名字里的 "100M" **不是网卡速率** —— 它的网卡实际是 **千兆(1Gb)**。
> 真正 100Mb 网卡的是 A100 / Q1 / X96-Air-100Mb。**不要按名字推断硬件。**

### N1 / S905D 全部变体

| ID | 型号 | DTB | 网卡 | WiFi | 官方BUILD |
|---|---|---|---|---|---|
| 101 | Phicomm-N1 | `meson-gxl-s905d-phicomm-n1.dtb` | 1Gb | brcm43455 | ✅ |
| 102 | Phicomm-N1(DMA-thresh) | `meson-gxl-s905d-phicomm-n1-thresh.dtb` | 1Gb | brcm43455 | — |

### 本机（开发者机器）确认

| 项 | 值 |
|---|---|
| 主板丝印 | X96 Q5X3 V4.1 |
| SoC | Amlogic S905X3 |
| RAM / eMMC | 4GB / 64GB |
| WiFi/蓝牙 模块 | Fn-Link **8274B-SR** = 芯片 **RTL8822CS** |
| 标签 | QCPASS 4+64+W522A |
| **对应数据库条目** | **ID 501 `X96-Max+_100Mb`**（rtl8822cs-wifi，完全匹配） |
| **对应 DTB** | `meson-sm1-x96-max-plus-100m.dtb` |

> 主板丝印 `Q5X3 V4.1` 不是型号依据；权威依据是 WiFi 芯片：`8274B-SR → RTL8822CS`，
> 与数据库 ID 501 标注的 `rtl8822cs-wifi` 一致。

## 三、当前构建（Phase 1）

**Phase 1 目标：最小可启动固件。**

| 项 | 值 |
|---|---|
| OpenWrt | `openwrt:25.12.5`（可切换 24.10.8 / immortalwrt） |
| Linux Kernel | **auto_kernel=true** → 自动跟随最新稳定（当前 6.18.y） |
| 打包体系 | [ophub/amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt) action |
| 内核来源 | [ophub/kernel](https://github.com/ophub/kernel) `stable` tag |
| Board | `s905x3` (X96Max+) + `s905d` (N1) |
| 默认 IP | `192.168.1.1` |
| 默认账号 | `root` / `password` |

### Phase 1 内置功能

- LuCI（Argon 主题、中文）
- SSH（dropbear + openssh-sftp）
- ttyd 网页终端、文件管理、系统备份/升级
- 网络诊断、流量统计（nlbwmon / vnstat2 / statistics）
- 磁盘管理（diskman / hd-idle）
- USB 存储、ext4/vfat/exfat/ntfs3/btrfs/xfs/f2fs
- WiFi 驱动：**RTL8822CS**（X96Max+）、**BCM43455**（N1）
- 蓝牙
- Amlogic 安装服务（luci-app-amlogic，用于写入 eMMC）

## 四、刷机方法

### 1. 下载
从 [Releases](../../releases) 下载对应设备的 `.img` 文件。

### 2. 写入 SD 卡 / U 盘
用 **balenaEtcher** / **Rufus** / `dd` 把 `.img` 写入 SD 或 U 盘。
```bash
# Linux 示例（确认 /dev/sdX 是你自己的卡！）
sudo dd if=*.img of=/dev/sdX bs=4M status=progress conv=fsync
```

### 3. 启动
- **X96 Max+**：插入 SD 卡，按住复位键（AV 口内的按钮）通电，直到出现 OpenWrt 启动画面。
- **N1**：插入 U 盘/SD，通电即可（已刷过 OpenWrt 的 N1 直接从 U 盘启动）。

### 4. 写入 eMMC（可选，推荐）
1. 从 SD/U 盘启动后，浏览器打开 `http://192.168.1.1`（root / password）
2. `系统` → `Amlogic 服务` → `安装 OpenWrt` → 选择目标 eMMC
3. 安装完成后拔掉 SD 卡重启

## 五、恢复 / 救砖

| 情况 | 恢复方法 |
|---|---|
| 刷错固件，仍能进 U-Boot | 重新用 SD 卡启动原厂/正确固件 |
| X96 Max+ 变砖 | 用 **Amlogic USB Burning Tool** + 原厂线刷包（需拆机短接或复位键进 MaskROM） |
| N1 变砖 | 用 **USB Burning Tool** + N1 原厂降级包（需拆机短接触点） |
| 配置错误无法进 LuCI | 拔电后按住复位键通电，进入 **failsafe 模式**（`http://192.168.1.1`） |

> 强烈建议刷机前备份原厂固件与 MAC 地址。

## 六、路线图

| 阶段 | 内容 | 状态 |
|---|---|---|
| **Phase 1** | OpenWrt + Kernel + Amlogic + X96Max+ + N1 最小可启动 | 🔄 进行中 |
| Phase 2 | Samba / NFS / SQM / MWAN3 / WireGuard / OpenVPN / DDNS / UPnP / WOL | ⏳ |
| Phase 3 | SmartDNS / AdGuard Home / MosDNS / OpenClash / PassWall / PassWall2 / Xray / V2Ray | ⏳ |
| Phase 4 | Docker / qBittorrent / Transmission / Aria2 / Rclone / Netdata | ⏳ |

> 原则：**先保证编译成功 → 镜像生成 → DTB 正确 → 刷机启动，再逐步加入插件。**
> 若某插件无法编译，记录原因，不强行塞入导致整个矩阵失败。

## 七、自动构建

- **手动触发**：Actions → `Build OpenWrt (X96Max+ / N1)` → Run workflow
- **每周自动**：每周一 03:00 UTC 检查上游更新
- 产物：`*.img` + `sha256sum.txt`，上传 Artifact 并发布 Release

## 八、开发说明

```
.
├── .github/workflows/build.yml          # 唯一构建入口
├── config/
│   └── imagebuilder/
│       ├── imagebuilder.sh              # 构建脚本（核心包清单在此）
│       ├── config                       # Phase 1 附加包清单
│       ├── files/                       # 自定义 overlay 文件
│       └── packages/                    # 可选：本地 .ipk/.apk
└── README.md
```

**修改设备范围**：编辑 `build.yml` 的 `openwrt_board`（逗号分隔 board 名）。
**新增插件**：加入 `config/imagebuilder/config`，格式 `CONFIG_PACKAGE_xxx=y`。

## 九、致谢

- [ophub/amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt) — Amlogic 打包体系
- [ophub/kernel](https://github.com/ophub/kernel) — 内核
- [unifreq/openwrt_packit](https://github.com/unifreq/openwrt_packit) — 原始打包脚本
- [haiibo/OpenWrt](https://github.com/haiibo/OpenWrt) — 项目理念来源
- OpenWrt / ImmortalWrt 上游

## 十、许可

GPL-2.0
