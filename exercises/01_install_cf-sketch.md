Install cf-sketch
=================
cf-sketch is a tool to help install and activate sketches from the CFEngine Design Center. Some of our goals may be covered by pre-existing policy so installing cf-sketch is a sensible starting place.

* [Design Center](https://github.com/cfengine/design-center "CFEngine Design Center on Github")

Task
----
Since we dont have any way for the policy hub to update its own /var/cfengine/masterfiles yet we will have to log into the node and add the policy directly. Note I said add the policy directly, I did not say manually install cf-sketch!

Take a look at the manual install process. We can use this knowledge to write our policy.
https://github.com/cfengine/design-center/wiki/Getting-started-with-cf%E2%80%93sketch

We need the following packages installed
* git
* make
* perl-List-MoreUtils
* perl-libwww-perl
* perl-JSON
* perl-Crypt-SSLeay (its not documented, but I needed it to access the design center repo vs a local clone)

We need to clone the design center repository

We need to run `make install` from the tools/cf-sketch directory in the design center.

Lets integrate the solution into our policy.

    vagrant ssh cfhub
    sudo mkdir /var/cfengine/masterfiles/solutions/
    sudo cp  /vagrant/exercises/solutions/01_install_cfsketch.cf /var/cfengine/masterfiles/solutions/01_install_cfsketch.cf
    cf-promises -f /var/cfengine/masterfiles/promises.cf
    cf-agent -KIB
    cf-agent -KI

This policy should have installed cf-sketch into /usr/local/bin. Go ahead and test it out.
/usr/local/bin/cf-sketch --search utilities

Cool we can see it found some sketches! Lets move on to the next exercise.
