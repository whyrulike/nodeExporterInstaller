# nodeExporterInstaller
install node exporter

wget -q -O - https://raw.githubusercontent.com/whyrulike/nodeExporterInstaller/main/node_exporter_install.sh | bash 

### use ansible

ansible beacon -i ./host -m shell -a "wget -q -O - https://raw.githubusercontent.com/whyrulike/nodeExporterInstaller/main/node_exporter_install.sh | bash"

ansible beacon -i ./host -m shell -a "sudo lsof -i:9100"
