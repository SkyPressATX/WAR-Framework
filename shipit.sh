#!/bin/bash
#Author: BMO
#Version: 0.1.0-alpha


if [[ -z ${rep} ]]; then
	dir=$(pwd -P)
	current_branch=$(git rev-parse --abbrev-ref HEAD)
	git checkout -b shipit $(git subtree split -P ${rep})
	find ${dir}/wordpress/wp-content -type f -iname "composer.json" -d 3 -execdir composer install --prefer-source -o \;
	git add . --all
	git commit -am "Pre-ship commit"
	git push ${rep} :shipit
	git checkout ${current_branch}
	git branch -D shipit
	exit 0
fi
