kvm-guest, an Ansible role
=========

Create a virtual machine named "kvm-guest" using libvirt. 
The role uses a kickstart file to install RHEL 8.2, register with RHSM, update then power off (the VM should reboot, but a QEMU option prevents that).
This role is simple, with hardcoded values in both the tasks and kickstart file _templates/kvm-guest.ks.j2_. 
I made this role to learn more about the libvirt collection.

The role creates these resources.

* kvm-guest - a libvirt domain
* kvm-guest.qcow2 - a 50GB root disk

Login

* user: root
* password: Password;1
* user: nick
* password: Password;1

Playbook _tests/no-kvm-guest.yml_ deletes these. 

Requirements
------------

The libvirt environment installed and running. 

Installer ISO file _/var/lib/libvirt/images/rhel-8.2-x86_64-dvd.iso_. Download this from https://access.redhat.com/downloads/. Sign up for free at https://developers.redhat.com/ to get access.

50GB free storage (I messed up the thin provisioning). 


Role Variables
--------------

RHSM Red Hat Subscription Manager account. The kickstart file signs up with these. 

* subscription_name
* subscription_password
* subscription_pool

Dependencies
------------

community.libvirt collection

Example Playbook
----------------

Create the VM. 

```
mkdir -p ~/ansible/roles
cd ~/ansible/roles
git clone https:/github.com/nickhardiman/virtualization-host.git
sudo ansible-playbook kvm-guest/tests/test.yml \
	--extra-var="subscription_name=my_user"  \
	--extra-var='subscription_password=my_password'  \
	--extra-var="subscription_pool=my_pool_id"
```

Remove the VM.

```
sudo ansible-playbook kvm-guest/tests/no-kvm-guest.yml
```

License
-------

BSD

Author Information
------------------

Nick Hardiman

