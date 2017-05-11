# vagrant-fuse-ansible

## NOTE

his version of the Vagrant file uses the ansible_local provisioner

https://www.vagrantup.com/docs/provisioning/ansible_local.html

There is another branch that uses plain shell scripts to run ansible (branch is called 'shell_based')

## Instructions

This demo is based on the fuse ansible playbooks developed at

https://github.com/rmarting/ansible-playbook-fuse
    
Though currently it uses a fork

https://github.com/petenorth/vagrant-fuse-ansible
    
These require a nexus server (attempting to use a local filesystem maven repo will not work due to 

https://github.com/ansible/ansible-modules-extras/issues/2547
    
The easiest way to run a nexus server is by using the Sonatype docker image

https://github.com/sonatype/docker-nexus
    
This maven repo then needs to be populated with a number of different maven artifacts. The projects where these can be found are at

Camel A-MQ Samples from https://github.com/rmarting/camel-amq-samples.git

Camel CXF Samples from https://github.com/rmarting/fuse-demo.git
   
Note that after git cloning the 'karaf-fuse-6.3.0' branch must be checked out, the nexus host if running via docker will be localhost so either the pom.xml files must bee updated or an entry added to your /etc/hosts file and then all of the projects built via the maven command

    mvn deploy
    
Once this is complete then

    vagrant up node1 admin1
    
    


