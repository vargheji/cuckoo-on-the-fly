CURRENTUSER="$(whoami)"
export CURRENTUSER
echo "test"
#Adding repositories
sudo add-apt-repository universe
echo "Provide Password"
sudo add-apt-repository multiverse
sudo echo "deb https://download.virtualbox.org/virtualbox/debian disco contrib" | sudo tee -a /etc/apt/sources.list
sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
#Updating and installing prerequisites
sudo apt-get update