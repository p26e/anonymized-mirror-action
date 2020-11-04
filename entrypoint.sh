#!/bin/sh

# Setup ssh
mkdir -p ~/.ssh
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Rewrite authors
git filter-branch --env-filter '
	export GIT_COMMITTER_NAME="$ANNON_NAME"
	export GIT_COMMITTER_EMAIL="$ANNON_EMAIL"
	export GIT_AUTHOR_NAME="$ANNON_NAME"
	export GIT_AUTHOR_EMAIL="$ANNON_EMAIL"
	' --tag-name-filter cat -- --branches --tags

# Update remote URL
git remote set-url origin "$DESTINATION_GIT_URL"

# Push to destination
git push --force --tags origin HEAD:"$MIRROR_BRANCH"
