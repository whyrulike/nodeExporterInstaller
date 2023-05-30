#!/bin/bash

RELEASE_VERSION="1.4.0"
RELEASE_OS="linux"
RELEASE_ARCH="amd64"
RELEASE_ARCHIVE="node_exporter-${RELEASE_VERSION}.${RELEASE_OS}-${RELEASE_ARCH}.tar.gz"
WORK_DIR="$HOME/node_exporter_install"

# 创建工作目录
mkdir -p "$WORK_DIR"

# 下载并解压 Node Exporter
wget -q "https://github.com/prometheus/node_exporter/releases/download/v$RELEASE_VERSION/$RELEASE_ARCHIVE" -O "$WORK_DIR/$RELEASE_ARCHIVE"
tar -xzf "$WORK_DIR/$RELEASE_ARCHIVE" -C "$WORK_DIR"

# 安装 Node Exporter
sudo mv "$WORK_DIR/node_exporter-$RELEASE_VERSION.$RELEASE_OS-$RELEASE_ARCH/node_exporter" /usr/local/bin/
sudo useradd --system --no-create-home --shell /bin/false node_exporter

# 创建 Systemd 服务
sudo tee /etc/systemd/system/node_exporter.service > /dev/null << EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# 启动 Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter

# 检查端口是否被监听
sudo lsof -i:9100
