## Cascadia node grafana monitoring dashboard (works on any cosmos chain)

## 1. On the node side
- enable Prometheus in validator config.toml file
- install cosmos-exporter / node-exporter (ports 9100 & 9300 are used)
```bash
git clone https://github.com/ryssroad/cascadia-monitoring
cd cascadia-monitoring
chmod u+x install_exporters.sh
./install_exporters.sh
```
- Check exporters services status
```bash
systemctl status cosmos-exporter.service
systemctl status node_exporter.service
ss -tulpn | grep '9100\|9300'
```
## 2. On separate host (1/1/20 works)
- install Docker + Docker Compose
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```
- install & start Grafana + Prometheus docker
```bash
git clone https://github.com/ryssroad/cascadia-monitoring
cd cascadia-monitoring
chmod u+x add_validator.sh
./add_validator.sh
docker-compose up -d
```
- login to grafana admin http://server_ip:9999 (default login **admin:admin**)
- import dashboard **18825**
