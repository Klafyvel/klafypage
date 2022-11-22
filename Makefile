JULIA=$(shell which julia)
SSHTARGET=root@klafyvel.me
SSHREMOTEDIR=/var/www/klafypage

default: continuous 

continuous:
	${JULIA} --project -e 'using Franklin;serve()'

build:
	${JULIA} --project -e 'import Pkg; Pkg.instantiate();using NodeJS; run(`$$(npm_cmd()) install highlight.js`);using Franklin;optimize()'

publish: build
	git -C __site/ commit -a -m "Automatic website build."
	git -C __site/ push
	ssh $(SSHTARGET) git -C $(SSHREMOTEDIR) pull

gh-pages-in: 
	git worktree add __site/ gh-pages

gh-pages-out:
	git worktree remove __site/
	git worktree prune

clean:
	rm -r __site/

.PHONY: clean default build gh-pages-in gh-pages-out continuous publish
