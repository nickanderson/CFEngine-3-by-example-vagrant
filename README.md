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
2. Setup a local webserver to serv the seed.tar.gz. The Vagrantfile 
   is configured for the CFEngine provisioner to look for the seed
   at http://localhost:8000/seed.tar.gz. You can bring up a simple 
   webserver from the Vagrant project directory with 
   `python -m SimpleHTTPServer`.


TODO
----
* Excersises designed to get you used to working with CFEngine 3 for hads off administration.
