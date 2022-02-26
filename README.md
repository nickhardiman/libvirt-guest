Create a virtual machine using libvirt. 
This installs RHEL 8.2 using a kickstart file. 
Simple role with hardcoded values. 

The role creates these resources.

* kvm-guest - a libvirt domain
* kvm-guest.qcow2 - a 50GB root disk


Role Name
=========

kvm-guest

Requirements
------------

libvirt environment installed and running. 

Installer ISO file /var/lib/libvirt/images/rhel-8.2-x86_64-dvd.iso. This is hardcoded in tasks/vm.yml. 

50GB free storage. 


Role Variables
--------------

RHSM Red Hat Subscription Manager account

* subscription_name
* subscription_password
* subscription_pool

Dependencies
------------

community.libvirt collection

Example Playbook
----------------

```
mkdir -p ~/ansible/roles
cd ~/ansible/roles
git clone https:/github.com/nickhardiman/virtualization-host.git
sudo ansible-playbook kvm-guest/tests/test.yml \
	--extra-var="subscription_name=my_user"  \
	--extra-var='subscription_password=my_password'  \
	--extra-var="subscription_pool=my_pool_id"
```

License
-------

BSD

Author Information
------------------

Nick Hardiman

