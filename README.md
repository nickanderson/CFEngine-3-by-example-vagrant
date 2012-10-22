CFEngine 3 by Example - Vagrant Project
=======================================

A vagrant project to bootstrap a test enviornment.

This project will bring up a CFEngine hub and a remote agent.

* cfhub - 10.1.1.10
* cfclient - 10.1.1.11

Quickstart
----------
Want to get going as fast as possible?

    git clone git://github.com/nickanderson/CFEngine-3-by-example-vagrant.git
    cd packages
    wget http://cfengine.com/pub/yum/i386/cfengine-community-3.3.5-1.i368.rpm
    mv cfengine-community-3.3.5-1.i368.rpm cfengine-community-3.3.5-1.i386.rpm
    cd ..
    make
    vagrant up 

Getting Started
---------------

1. Run `make` - This will prepare seed.tar.gz. This seed policy is source
   from [here](https://github.com/nickanderson/CFEngine-3-by-example-seed
   "CFEngine 3 by example seed repository").  It also creates
   masterfiles.git in the Vagrant project directory which is a bare git
   repository of masterfiles from the seed. This repository is used as the
   "central repository". The hubs `/var/cfengine/masterfiles` is kept in a
   clean clone state from the repository. Changes to the policy are intended
   to be made by checking the changes into this repository. This is a typical
   workflow and is intended to familarize you with hands off administration.

2. Run `vagrant up` and in a few minutes you will have a hub and a client
   bootstrapped.

3. Clone the masterfiles.git repository so you can start writing policy!

    git clone masterfiles.git

### Special Note ###
The CFEngine Provisioner plugin is still in active developemnt, things may
be changing. The version of the Vagrant CFEngine provisioner this
Vagrantfile was tested against is deposited in the Vagrant project
directory as part of `make`.

### Windows Users ###
I have successfully tested this on windows. You need the vagrant msi package,
virtualbox, and cygwin with tar, and git. wget and vim are also useful to have.
You will need to the the git clone and make from a Cygwin shell and run
`vagrant.bat up` instead of `vagrant up`.

You might try installing cygwin like this:
    setup.exe --quiet-mode --packages openssh, wget, tar, git 


TODO
----
* Excersises designed to get you used to working with CFEngine 3 for hands
  off administration.
