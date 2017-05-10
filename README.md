# vagrant-fuse-ansible

This demo is based on the fuse ansible playbooks developed at

    https://github.com/rmarting/ansible-playbook-fuse
    
These require a nexus server (attempting to use a local filesystem maven repo will not work due to 

    https://github.com/ansible/ansible-modules-extras/issues/2547
    
The easiest way to run a nexus server is by using the Sonatype docker image

    https://github.com/sonatype/docker-nexus
    
This maven repo then needs to be populated with a number of different maven artifacts. The projects where these can be found are at

