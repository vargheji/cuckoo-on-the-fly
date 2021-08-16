	pip install git+https://github.com/gussj/vmcloak.git
	vmcloak-vboxnet0
	vmcloak init --verbose --win7x64 win7x64base --cpus 2 --ramsize 2048
	vmcloak clone win7x64base win7x64cuckoo
	vmcloak install win7x64cuckoo adobepdf pillow dotnet java flash vcredist vcredist.version=2015u3 wallpaper ie11
	vmcloak snapshot --count 4 win7x64cuckoo_ 192.168.56.101
	sudo sysctl -w net.ipv4.conf.vboxnet0.forwarding=1
	sudo sysctl -w net.ipv4.conf.eth0.forwarding=1
	sudo iptables -t nat -A POSTROUTING -o eth0 -s 192.168.56.0/24 -j MASQUERADE
	sudo iptables -P FORWARD DROP
	sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -s 192.168.56.0/24 -j ACCEPT
	cuckoo init
	cuckoo web --host 127.0.0.1 --port 8080
	supervisord -c /home/cuckoo/.cuckoo/supervisord.conf
	echo "Finish VMCloack and Cuckoo Installation. You can use (supervisorctl start cuckoo) to start cuckoo in the background."