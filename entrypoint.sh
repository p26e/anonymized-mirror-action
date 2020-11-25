#!/bin/bash

# Exit if the current remote URL is the destination URL
if git config --get remote.origin.url | grep -q "$INPUT_DESTINATION_GIT_URL"; then
	exit 0
fi

# Setup ssh
mkdir -p ~/.ssh
echo "$INPUT_SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Remove files
ls -la
if [ ! -z "$INPUT_REMOVE" ]; then
	readarray -td, a <<<"$INPUT_REMOVE,"; unset 'a[-1]';
	for file in "${a[@]}"; do
		echo rm -rf "$file"
	done
fi

# Rewrite authors
git filter-branch --env-filter '
	export GIT_COMMITTER_NAME="$INPUT_ANON_NAME"
	export GIT_COMMITTER_EMAIL="$INPUT_ANON_EMAIL"
	export GIT_AUTHOR_NAME="$INPUT_ANON_NAME"
	export GIT_AUTHOR_EMAIL="$INPUT_ANON_EMAIL"
	' --tag-name-filter cat -- --branches --tags

# Don't host check
git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# Update remote URL
git remote set-url origin "$INPUT_DESTINATION_GIT_URL"

# Push to destination
git push --force --tags origin "HEAD:$INPUT_MIRROR_BRANCH"
