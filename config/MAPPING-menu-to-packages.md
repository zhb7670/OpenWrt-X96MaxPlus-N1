# 菜单项 → OpenWrt 包名 映射对照表
# 目的：把原固件菜单逐项映射为可安装的包，标注来源(feed)
# 图例：
#   [官方]   = downloads.openwrt.org 官方 feed 有
#   [OPHUB]  = ophub/luci-app-amlogic release (已在本项目处理)
#   [三方]   = 需第三方 feed (kenzok8/small-package, jerrykuku, 等)
#   [内核]   = 需 CONFIG 内核选项，ImageBuilder 无法解决，需源码编译

==================================================================
状态 (11)  —— 全部由 LuCI 内置模块 / 官方包提供
==================================================================
概览            luci-mod-status / luci-mod-dashboard        [官方]
防火墙          luci-app-firewall                           [官方]
路由表          luci-app-route / (netstat-nat)              [官方]
系统日志        luci-mod-status (system log)                [官方]
内核日志        luci-mod-status (kernel log)                [官方]
系统进程        luci-app-commands / luci-mod-status         [官方]
实时信息        luci-app-statistics                        [官方]
实时监控        luci-app-statistics + luci-app-nlbwmon     [官方]
WireGuard 状态  luci-proto-wireguard + luci-app-wireguard  [官方]
负载均衡        luci-app-mwan3                             [官方]
释放内存        luci-app-commands / luci-app-ramfree(三方?) [官方/三方]

==================================================================
系统 (14)
==================================================================
系统            luci-mod-system                             [官方]
管理权          luci-mod-system (admin)                     [官方]
TTYD 终端       luci-app-ttyd                               [官方][已装]
软件包          luci-app-opkg                               [官方]
启动项          luci-mod-system (startup)                   [官方]
计划任务        luci-mod-system (crontab)                   [官方]
挂载点          luci-app-fstab / block-mount               [官方]
磁盘管理        luci-app-diskman                            [三方]
备份升级        luci-mod-system (backup)                    [官方]
重启            luci-mod-system                             [官方]
晶晨宝盒        luci-app-amlogic                            [OPHUB][已处理]
定时重启        luci-app-autoreboot                         [三方]
文件传输        luci-app-filetransfer                       [三方]

==================================================================
服务 (43)
==================================================================
PassWall 2          luci-app-passwall2                      [三方]
DAE                 luci-app-dae (kenzok8)                  [三方]
PassWall            luci-app-passwall                       [三方]
Hello World         luci-app-helloworld                     [三方]
iKoolProxy          luci-app-ikoolproxy                     [三方]
V2ray 服务器        luci-app-v2ray-server / v2ray           [三方]
广告屏蔽大师 Plus+  luci-app-adblock-plus / adblock        [三方]
AdGuard Home        luci-app-adguardhome                    [三方]
ShadowSocksR Plus+  luci-app-ssr-plus                      [三方]
微信推送            luci-app-wechatpush                     [三方]
上网时间控制        luci-app-access-control / timecontrol   [三方]
全能推送            luci-app-pushbot                        [三方]
MosDNS              luci-app-mosdns                         [三方]
解锁网易云灰歌      luci-app-unblockmusic                   [三方]
OpenClash           luci-app-openclash                      [三方]
DDNS-GO             luci-app-ddns-go                        [三方]
动态 DNS            luci-app-ddns                           [官方]
SmartDNS            luci-app-smartdns                       [三方]
网络唤醒            luci-app-wol                            [官方]
迅雷快鸟            luci-app-xlnetacc                       [三方]
WatchCat            luci-app-watchcat                       [官方]
Frps                luci-app-frps                           [三方]
UU游戏加速器        luci-app-uugamebooster                  [三方]
Frp 内网穿透        luci-app-frpc                           [三方]
udpxy               luci-app-udpxy                          [三方]
AirPlay 2 音频接收  luci-app-airplay2 / shairport-sync     [三方]
OpenConnect VPN     luci-app-openconnect / ocserv           [官方]
UPnP                luci-app-upnp                           [官方]
Shairplay           luci-app-shairplay + shairplay          [三方]
Nps 内网穿透        luci-app-nps                            [三方]
speederv2 隧道      luci-app-speederv2 / speederv2          [三方]
Gost                luci-app-gost                           [三方]
HAProxy             luci-app-haproxy                        [三方]
uHTTPd              luci-app-uhttpd (luci-mod?)             [官方]
udp2raw 隧道        luci-app-udp2raw                        [三方]
KMS 服务器          luci-app-vlmcsd / vlmcsd                [三方]
Tinyproxy           luci-app-tinyproxy                      [官方]
MWAN3 分流助手      luci-app-mwan3                          [官方]

==================================================================
Docker (7)  —— 需 docker-daemon + luci-app-dockerman
==================================================================
概览/容器/镜像/网络/存储卷/事件/配置  luci-app-dockerman  [三方]
                                      dockerd containerd runc [官方][已装]
⚠️ Docker 需内核 cgroups/namespaces/overlayfs (OPHUB 内核已含)

==================================================================
网络存储 (18)
==================================================================
文件浏览器          luci-app-filebrowser                    [三方]
可道云              kodbox / luci-app-kodbox                [三方]
NFS 管理            luci-app-nfs / nfs-kernel-server        [官方]
微力同步            verysync / luci-app-verysync            [三方]
Alist               luci-app-alist                          [三方]
qBittorrent         luci-app-qbittorrent                    [三方]
USB 打印服务器      luci-app-usb-printer / p910nd           [官方]
硬盘休眠            luci-app-hd-idle                        [官方][已装]
打印服务器          luci-app-p910nd                         [官方]
网络共享            luci-app-samba4                         [官方]
miniDLNA            luci-app-minidlna                       [官方]
FTP 服务器          luci-app-vsftpd                         [官方]
Transmission        luci-app-transmission                   [官方]
MJPEG-streamer     luci-app-mjpg-streamer                  [官方]
Rclone              luci-app-rclone                         [三方]
Aria2 配置          luci-app-aria2                          [三方]
挂载 SMB 共享       luci-app-cifs-mount                     [官方]
PCHiFi 数字转盘遥控 luci-app-dacp / (第三方 dac)             [三方]

==================================================================
VPN (9)
==================================================================
SSR MuDB 服务器     ssr-mudb-server                         [三方]
SSR Python 服务器   luci-app-ssr-server / shadowsocksr      [三方]
N2N VPN             luci-app-n2n                            [三方]
SoftEther VPN       softethervpn / luci-app-softether       [三方]
IPSec VPN 服务器    luci-app-strongswan / strongswan        [官方]
PPTP VPN 服务器     luci-app-pptp-server                    [官方]
OpenVPN 服务器      luci-app-openvpn                        [官方]
ZeroTier            luci-app-zerotier                       [官方]
OpenVPN             openvpn-openssl + luci-app-openvpn      [官方]

==================================================================
网络 (14)  —— 绝大多数官方
==================================================================
接口            luci-mod-network                        [官方]
无线            luci-mod-network                        [官方]
DHCP/DNS        luci-mod-network / dnsmasq              [官方]
主机名          luci-mod-system                         [官方]
IP/MAC 绑定     luci-mod-network                        [官方]
静态路由        luci-mod-network                        [官方]
网络诊断        luci-mod-network                        [官方]
防火墙          luci-app-firewall                       [官方]
SQM QoS         luci-app-sqm                            [官方]
Socat           luci-app-socat                          [官方]
网速控制        luci-app-wrtbwmon / luci-app-nft-qos    [三方/官方]
Turbo ACC        luci-app-turboacc                       [三方]
多线多拨        luci-app-mwan3 / luci-app-multiwan      [三方]
负载均衡        luci-app-mwan3                          [官方]
