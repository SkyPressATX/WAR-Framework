#!/bin/bash
#Author: BMO
#Version: 0.1.0-alpha


if [[ -n ${1} ]]; then
	dir=$(pwd -P)
	current_branch=$(git rev-parse --abbrev-ref HEAD)
	git subtree split --prefix=wordpress -b shipit
	git checkout shipit
	find ${dir}/wp-content -type f -iname "composer.json" -d 3 -execdir composer install --prefer-source -o \;
	git add . --all
	git commit -am "Pre-ship commit"
	git push -f --squash ${1} :shipit
	git checkout ${current_branch}
	git branch -D shipit
	exit 0
fi
