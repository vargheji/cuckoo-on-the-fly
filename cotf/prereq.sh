CURRENTUSER="$(whoami)"
export CURRENTUSER
#Adding repositories
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo tee -a /etc/apt/sources.list
sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
#Updating and installing prerequisites
sudo apt-get update
sudo apt-get upgrade --allow-downgrades --allow-remove-essential --allow-change-held-packages
sudo apt-get install iptables-persistent git libffi-dev libjpeg8-dev zlib1g-dev genisoimage supervisor uwsgi uwsgi-plugin-python nginx build-essential unzip python-django python python-dev python-pip python-pil python-sqlalchemy python-bson python-dpkt python-jinja2 python-magic python-pymongo python-gridfs python-libvirt python-bottle python-pefile python-chardet tcpdump apparmor-utils libjpeg-dev python-virtualenv python3-virtualenv virtualenv swig libpq-dev autoconf libtool libjansson-dev libmagic-dev libssl-dev virtualbox-5.2 volatility supervisor ssdeep -y
#Creating new user 'cuckoo'. Here the user is created with password disabled as per cuckoo documentation. However it is advised to set password before switching to cuckoo user.
sudo adduser --disabled-password --gecos "" cuckoo
sudo groupadd pcap
sudo usermod -a -G pcap cuckoo
echo "Provide password for user 'cuckoo'"
sudo passwd cuckoo
# tcpdump setup
sudo chgrp pcap /usr/sbin/tcpdump
sudo aa-disable /usr/sbin/tcpdump
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
#Directory creation
cd
sudo mkdir /home/"$CURRENTUSER"/cotf
cd /home/"$CURRENTUSER"/cotf
sudo mkdir files
cd files
#Yara setup
sudo wget https://github.com/VirusTotal/yara/archive/v3.11.0.tar.gz -O yara-3.11.0.tar.gz
sudo tar -zxf yara-3.11.0.tar.gz
cd yara-3.11.0
sudo ./bootstrap.sh
sudo ./configure --enable-cuckoo --enable-magic
sudo make
sudo make install
sudo ln -s /usr/local/lib/libyara.so.3 /usr/lib/libyara.so.3
sudo wget https://github.com/VirusTotal/yara-python/archive/v3.11.0.tar.gz -O yara-python.tar.gz
sudo tar -zxf yara-python.tar.gz
cd yara-python-3.11.0
sudo python setup.py build
sudo python setup.py install
#ssdeep setup
cd /home/"$CURRENTUSER"/cotf/files/
sudo wget https://github.com/ssdeep-project/ssdeep/releases/download/release-2.14.1/ssdeep-2.14.1.tar.gz -O ssdeep-2.14.1.tar.gz
sudo tar -zxf ssdeep-2.14.1.tar.gz
cd ssdeep-2.14.1
sudo ./configure
sudo make
sudo make install
pip install pydeep
pip install openpyxl
pip install ujson
pip install pycrypto
pip install distorm3
pip install pytz
pip install jsonschema
#Setting up Volatility
cd /home/"$CURRENTUSER"/cotf/files/
sudo git clone https://github.com/volatilityfoundation/volatility.git
cd volatility
sudo python setup.py build
sudo python setup.py install
#VirtualBox setup
cd /home/"$CURRENTUSER"/cotf/files/
sudo wget https://download.virtualbox.org/virtualbox/5.2.34/Oracle_VM_VirtualBox_Extension_Pack-5.2.34.vbox-extpack
sudo VBoxManage extpack install https://download.virtualbox.org/virtualbox/5.2.34/Oracle_VM_VirtualBox_Extension_Pack-5.2.34.vbox-extpack --accept-license=56be48f923303c8cababb0bb4c478284b688ed23f16d775d729b89a2e8e5f9eb
sudo usermod -a -G vboxusers cuckoo
#Packer setup
cd /home/"$CURRENTUSER"/cotf/files/
sudo wget https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip
sudo unzip packer_1.5.1_linux_amd64.zip
sudo mv packer /usr/local/bin
sudo wget https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
sudo dpkg -i vagrant_2.2.6_x86_64.deb
echo "PASS"
    