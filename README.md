# Anonymized Repository Mirroring
Mirror an anonymized version of a branch to another repository.

_For this action to work it needs write access to the remote destination repository. If your remote repository is hosted on GitHub, we recommend adding the SSH-key (public) as a [deploy key](https://docs.github.com/en/free-pro-team@latest/developers/overview/managing-deploy-keys#deploy-keys) in the remote repository._

## Inputs

### `ssh_private_key`

**Required** The SSH key used when pushing to the destination repository.

### `destination_git_url`

**Required** URL of the remote destination repository.

### `mirror_branch`

The branch to write the anonymized mirror to. Default: `main`

### `anon_name`

The name all commits (both committer and author) will be rewritten to use. Default: `"anon"`

### `anon_email`

The email all commits (both committer and author) will be rewritten to use. Default: `"anon@example.com"`

## `remove_files`

Comma seperated list of files to remove before mirroring (e.g. `".github/workflows/mirror.yml,passwords.txt"`). Default: `""`

## Example usage

```yaml
# .github/workflows/mirror.yml

...
  steps:
    - uses: actions/checkout@v2 # <-- must be provided, else no source repo is provided to anonymized-mirror-action
      with:
        fetch-depth: "0" # <-- must be 0 to prevent shallow clone issues
        ref: "main" # <-- the branch you want to get mirrored and anonymized
    - uses: pstnorge/anonymized-mirror-action@main
      with:
        ssh_private_key: ${{ secrets.REMOTE_SSH_PRIVATE_KEY }} # <-- use GitHub secrets for the SSH key
        destination_git_url: "git@github.com:pstnorge/public-anonymized-repo.git"
        mirror_branch: "mirror"
        anon_name: "PST"
        anon_email: "noreply@pst.no"
        remove_files: ".github/workflows/mirror.yml" # Removes this file from the anonymized mirror
```
