    cd /home/"$CURRENTUSER"/cotf/
	sudo apt-get update
	sudo apt-get -y install python virtualenv python-pip python-dev build-essential
	sudo apt-get -y install postgresql postgresql-contrib
    echo "Downloading ISO file"
	sudo wget https://cuckoo.sh/win7ultimate.iso
	sudo mkdir /mnt/win7
	sudo mount -o ro,loop win7ultimate.iso /mnt/win7
	sudo apt-get -y install build-essential libssl-dev libffi-dev python-dev genisoimage mongodb supervisord
	sudo apt-get -y install zlib1g-dev libjpeg-dev
	sudo apt-get -y install python-pip python-virtualenv python-setuptools swig
	pip install --upgrade pip
	pip install pillow
	pip install --upgrade pillow
    echo "PASS"