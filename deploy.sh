cd /home/vagrant/ansible-playbook-fuse
ansible-playbook -i hosts fuse-deploy-bundle-vagrant.yaml --extra-vars "maven_repository_manager=http://10.0.2.2:8081/nexus/content/groups/public"
