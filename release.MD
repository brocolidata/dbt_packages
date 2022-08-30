# Release a brocoli dbt package

This repository use [semantic-release](https://github.com/semantic-release/semantic-release) to determine the consumer impact of changes in the codebase. Following formalized conventions for commit messages, semantic-release automatically determines the next semantic version number, generates a changelog and publishes the release.

## Conventional commit
See [semantic-release Commit Analyzer | Rules matching](https://github.com/semantic-release/commit-analyzer#rules-matching) To understand different rules.

*(TODO: use [releaseRules attribute](https://github.com/semantic-release/commit-analyzer#releaserules) to create custom rules)*

## Process to release
- Update the version in `dbt_project.yml`
- Create a commit following [Conventional commit](#conventional-commit)
- Push your commits and create a PR
- The release pipeline will run when the PR is merged

## Process to delete a release
You may need to delete a release because : 
- it was created accidentally
- it has missing commits

In order to delete the release : 
1. **Delete release** : Follow instructions in [GitHub docs | Delete a Release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#deleting-a-release)
2. **Delete tag** : Run the following command to delete the tag associated with the release (not inside the Remote Dev Container) 
*(replace `TAG_NAME` by the name of the tag you want to delete)* 
```
git push --delete origin TAG_NAME
```