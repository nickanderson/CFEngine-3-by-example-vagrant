# Investigate Seed Policy

A bare git repository (masterfiles.git) was created as part of the project initilization.
The policy server aka policy hub or just hub is configured to keep its 
/var/cfengine/masterfiles in sync with this repository. This repository is how you will interface
with your policy. Clone it so that you have a working copy.

    $ git clone masterfiles.git
    Cloning into 'masterfiles'...
    done.


Take a look the current policy. Remember promises.cf is the first file read
by the agent, so thats a good place to start.

Bundlesequence is a list of bundles to execute in order, thats a good place
to start looking for what policy would be activated.

There are several types of bundles listed in the reference manaul.
https://cfengine.com/manuals/cf3-reference

Get used to searching the policy. This is a useful search to locate a bundle of any type
by name. `find . -type f | xargs grep "bundle\s.*\sBUNDLENAME"`

    $ find . -type f | xargs grep "bundle\s.*\smain"
    ./sketches/VCS/vcs_mirror/README.md:    bundle agent main {
    ./main.cf:bundle agent main

Two matches found, one is in a README, the other is in main.cf. That seems
like a good place to start looking.

Read the policy in main.cf.

Can you find any policy that is activated on any agent?

Can you find any policy that is activated on agents that identify as a policy hub?

Can you find any policy that is activated on agents that do not identify as a policy hub? 


Excersise:
    Shutdown/halt non policy hubs that execute the agent from cf_execd

