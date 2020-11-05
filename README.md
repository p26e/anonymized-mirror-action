# Anonymized Repository Mirroring
Mirror an anonymized version of a branch to another repository.

_For this action to work it needs write access to the remote destination repository. If your remote repository is hosted on GitHub, we recommend adding the SSH-key (public) as a [deploy key](https://docs.github.com/en/free-pro-team@latest/developers/overview/managing-deploy-keys#deploy-keys) in the remote repository._

## Inputs

### `ssh_private_key`

**Required** The SSH key used when pushing to the destination repository.

### `destination_git_url`

**Required** URL of the remote destination repository.

### `anon_name`

The name all commits (both committer and author) will be rewritten to use. Default: `anon`

### `anon_email`

The email all commits (both committer and author) will be rewritten to use. Default: `anon@nowhere.tld`

### `mirror_branch`

The branch to mirror. Default: `main`

## Example usage

```yaml
...
  steps:
    - uses: actions/checkout@v2 # <-- must be provided, else no source repo is provided to anonymized-mirror-action
      with:
        fetch-depth: "0" # <-- must be 0 to prevent shallow clone issues
        ref: "main"
    - uses: pstnorge/anonymized-mirror-action@v1
      with:
        ssh_private_key: ${{ secrets.REMOTE_SSH_PRIVATE_KEY }} # <-- use GitHub secrets for the SSH key
        destination_git_url: "git@github.com:pstnorge/public-anonymized-repo.git"
        anon_name: "PST"
        anon_email: "noreply@pst.no"
```
