JULIA=$(shell which julia)

default: continuous 

continuous:
	${JULIA} --project -e 'using Franklin;serve()'

build:
	${JULIA} --project -e 'import Pkg; Pkg.instantiate();using NodeJS; run(`$$(npm_cmd()) install highlight.js`);using Franklin;optimize()'

gh-pages-in: 
	git worktree add __site/ gh-pages

gh-pages-out:
	git worktree remove __site/
	git worktree prune

clean:
	rm -r __site/

.PHONY: clean default build gh-pages-in gh-pages-out continuous
