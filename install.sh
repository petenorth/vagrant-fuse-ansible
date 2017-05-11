ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
for host in node1.example.com node2.example.com node3.example.com; \
    do ssh-copy-id -i /root/.ssh/id_rsa.pub $host; \
    done
cd /home/vagrant/ansible-playbook-fuse
cp /vagrant/fuse-install-vagrant.yaml .
cp /vagrant/fuse-deploy-bundle-vagrant . 
ansible-playbook -i hosts fuse-install-vagrant.yaml --extra-vars "maven_repository_manager=http://10.0.2.2:8081/nexus/content/groups/public"


