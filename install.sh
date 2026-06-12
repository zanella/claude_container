
mkdir -p  ~/.local/bin;

chmod +x cc.sh;

rm -f ~/.local/bin/ccc;

ln -s $PWD/cc.sh ~/.local/bin/ccc;

# https://devopscube.com/run-docker-in-docker/
#sudo chmod 666 /var/run/docker.sock;

# EOF

