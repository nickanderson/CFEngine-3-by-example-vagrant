TESTED_PROVISIONER_VERSION=0981c5ed95c3a3b413304a9e7d93dbc25ce17d41

default: clean ready 

clean:
	-rm seed.tar.gz
	-rm -rf masterfiles.git
	-rm -rf tmp
	-rm -rf masterfiles
	-rm -rf masterfiles.before_gitify

ready:
	mkdir -p tmp/seed
	git clone git://github.com/nickanderson/CFEngine-3-by-example-seed.git tmp/seed.clone
	cd tmp/seed.clone && git archive master | tar -x -C ../seed
	rm -rf tmp/seed.clone
	tar -czvf seed.tar.gz -C ./tmp/seed/ .
	cd tmp/seed/masterfiles/ && git init && git add . && git commit -m "Inital policy import"
	git clone --bare tmp/seed/masterfiles masterfiles.git
	cd masterfiles.git && git remote rm origin
	mkdir -p tmp/vagrant-cfengine-provisioner
	git clone https://github.com/cfengine/vagrant-cfengine-provisioner tmp/vagrant-cfengine-provisioner/
	cd tmp/vagrant-cfengine-provisioner && git reset --hard $(TESTED_PROVISIONER_VERSION)
	cp tmp/vagrant-cfengine-provisioner/cfengine_provisioner.rb .
	rm -rf tmp
