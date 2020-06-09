# #################################################################
# 脚本名称 : Ubuntu20.04X11VNC
# 脚本描述 : 自动安装配置和自动启动X11Vnc            
# 编辑日期 ：2020.6.9
# 编写日期 : 2016.6.13
# 原 作 者 : longhr 
# 作者网站 : blog.csdn.net/longhr
# 软件版本 : 0.2
# 免责声明 : 使用自由，后果自付 转载请注明原作者 
# #################################################################

# 步骤 1 - 安装 X11VNC  
# ################################################################# 
echo "installing X11VNC.."
sudo apt-get install x11vnc -y

# 步骤 2 - 配置访问密码
# ################################################################# 
echo "creating acess passwd.."
sudo x11vnc -storepasswd /etc/x11vnc.pass 


# 步骤 3 - 创建服务
# ################################################################# 

echo "creating service.."
cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc at startup.
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# 步骤 4 - 配配置防火墙端口，配置和启动服务
# ################################################################ 

echo "Configuring firewall.."
sudo ufw allow 5900
echo "Configure Services"
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

# 步骤 5 - 重启
# ################################################################ 
echo "Restart system in 5 sec!!!"
sleep  5s
sudo shutdown -r now 


