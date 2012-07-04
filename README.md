Getting-Started-with-CFEngine-3
===============================

A vagrant project to bootstrap a test enviornment.

This project will bring up a CFEngine hub and a remote agent.

* cfhub - 10.1.1.10
* cfclient - 10.1.1.11

Getting Started
---------------
1. Run `make ready` - This will prepare a seed.tar.gz containing policy
   that will be used by the CFEngine provisioner. More information about
   this policy can be found [here](https://github.com/nickanderson/Getting-Started-with-CFEngine-3-seed "Getting Started with CFEngine 3 seed Repository").  
   It also creates a bare clone of the repository that can be used with
   the excersises as the central version control repository that the
   policy hub pulls from.
2. Setup a local webserver to serv the seed.tar.gz. By default the 
   Vagrantfile looks at http://localhost:8000/seed.tar.gz. You can
   bring up a simple webserver from the Vagrant project directory
   with python.
   `python -m SimpleHTTPServer`


TODO
----
* Excersises designed to get you used to working with cfengine
* Work in typical version control -> masterfiles -> inputs flow

