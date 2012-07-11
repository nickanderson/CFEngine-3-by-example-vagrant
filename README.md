CFEngine 3 by Example - Vagrant Project
=======================================

A vagrant project to bootstrap a test enviornment.

This project will bring up a CFEngine hub and a remote agent.

* cfhub - 10.1.1.10
* cfclient - 10.1.1.11

Getting Started
---------------

1. Run `make` - This will prepare a seed.tar.gz containing policy
   that will be used by the CFEngine provisioner. More information about
   this policy can be found [here](https://github.com/nickanderson/CFEngine-3-by-example-seed "CFEngine 3 by example seed repository").  
   It also creates a bare clone of the repository that can be used with
   the excersises as the central version control repository that the
   policy hub pulls from.

### Special Note ###
The CFEngine Provisioner plugin is still in active developemnt, things may be changing.
This Vagrantfile was tested against 
* User/Project@SHA: cfengine/vagrant-cfengine-provisioner@0981c5ed95c3a3b413304a9e7d93dbc25ce17d41

TODO
----
* Excersises designed to get you used to working with CFEngine 3 for hands off administration.
