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
	cd tmp/seed.clone && git checkout 664b35fb94a42bcb0ae4b870de13bf9d5eb2dd27 && git archive master | tar -x -C ../seed
	rm -rf tmp/seed.clone
	tar -czvf seed.tar.gz -C ./tmp/seed/ .
	cd tmp/seed/masterfiles/ && git init && git add . && git commit -m "Inital policy import"
	git clone --bare tmp/seed/masterfiles masterfiles.git
	cd masterfiles.git && git remote rm origin
	rm -rf tmp
