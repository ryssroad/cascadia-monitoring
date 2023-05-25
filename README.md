## Cascadia node grafana monitoring dashboard (works on any cosmos chain too)

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
- install Grafana + Prometheus
```bash
git clone https://github.com/ryssroad/cascadia-monitoring
cd cascadia-monitoring
chmod u+x install_monitoring.sh
./install_monitoring.sh
docker-compose up -d
```
- login to grafana admin http://server_ip:9999 (default login **admin:admin**)
- import dashboard **18825**

- **OR** install Grafana + Prometheus manually and use **add_validator.sh** to configure Prometheus
