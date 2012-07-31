CFEngine 3 by Example - Vagrant Project
=======================================

A vagrant project to bootstrap a test enviornment.

This project will bring up a CFEngine hub and a remote agent.

* cfhub - 10.1.1.10
* cfclient - 10.1.1.11

Getting Started
---------------

1. Run `make` - This will prepare seed.tar.gz. This seed policy is
   source from [here](https://github.com/nickanderson/CFEngine-3-by-example-seed "CFEngine 3 by example seed repository").  
   It also creates masterfiles.git in the Vagrant project directory
   which is a bare git repository of masterfiles from the seed. This
   repository is used as the "central repository". The hubs 
   `/var/cfengine/masterfiles` is kept in a clean clone state from
   the repository. Changes to the policy are intended to be made by
   checking the changes into this repository. This is a typical 
   workflow and is intended to familarize you with hands off
   administration.

2. Run `vagrant up` and in a few minutes you will have a hub and a client bootstrapped.

3. Clone the masterfiles.git repository so you can start writing policy!

    git clone masterfiles.git

### Special Note ###
The CFEngine Provisioner plugin is still in active developemnt, things may be changing.
This Vagrantfile was tested against [cfengine/vagrant-cfengine-provisioner@0981c5ed95](https://github.com/cfengine/vagrant-cfengine-provisioner/commit/0981c5ed95c3a3b413304a9e7d93dbc25ce17d41)

TODO
----
* Excersises designed to get you used to working with CFEngine 3 for hands off administration.
* Excersise covering cf_promises_validated getting added to git ignore
