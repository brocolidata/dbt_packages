# Release a brocoli dbt package

The following guide explains how to format your **commits messages** in order to deploy **GitHub Releases**.

We follow [Angular Conventional Commits](https://www.conventionalcommits.org/) standard to format our **commit messages** . We use [semantic-release](https://github.com/semantic-release/semantic-release) to determine determines the next semantic version number based on the **commit messages** convention.

**Github Releases** are deployable software iterations you can package and make available for a wider audience to download and use.
Releases are based on Git tags, which mark a specific point in your repository's history. A tag date may be different than a release date since they can be created at different times.

The `[CD] Release dbt packages` GitHub Action located in `.github/workflows/release_CD.yml` deploys automatically releases when PRs are merged on the `main` branch.


## Table of Contents
1. [Git Commit Guidelines](#git-commit-guidelines)
2. [Commit Analyzer rules](#commit-analyzer-rules)
3. [Manage releases](#manage-releases)
4. [Useful links](#useful-links)

## Git Commit Guidelines
*(this section is a highly inspired from [Developing AngularJS | Git Commit Guidelines](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines))*

We have very precise rules over how our git commit messages can be formatted.  This leads to **more readable messages** that are easy to follow when looking through the **project history**.

#### Commit Message Format
Each commit message consists of a **header**, a **body** and a **footer**.  The header has a special format that includes a **type**, a **scope** and a **subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

The **header** is mandatory and the **scope** of the header is optional.

Any line of the commit message cannot be longer than 100 characters! This allows the message to be easier to read on GitHub.

We use the `Conventional Commits` VSCode extension as a UI to enforce the Commit Message standards. Its settings are all keys starting by `conventionalCommits.` in the `.vscode/settings.json`. 

### Revert
If the commit reverts a previous commit, it should begin with `revert: `, followed by the header of the reverted commit.
In the body it should say: `This reverts commit HASH.`, where the `HASH` is the SHA of the commit being reverted.

### Type
Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing
  semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing or correcting existing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such as documentation generation

### Scope
The scope could be anything specifying place of the commit change. 
The scopes are set in the `conventionalCommits.scopes` key of the `.vscode/settings.json` file.

You can use `*` when the change affects more than a single scope.

### Subject
The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end

### Body
Just as in the **subject**, use the imperative, present tense: `change` not `changed` nor `changes`.
The body should include the motivation for the change and contrast this with previous behavior.

### Footer
The footer should contain any information about **Breaking Changes** and is also the place to reference GitHub issues that this commit closes.

**Breaking Changes** should start with the word `BREAKING CHANGE:` with a space or two newlines.
The rest of the commit message is then used for this.


## Commit Analyzer rules
*(this section is a highly inspired from [semantic-release Commit Analyzer | Rules matching](https://github.com/semantic-release/commit-analyzer#rules-matching))*

**Important** : Your commits must be formatted exactly as specified in [Commit Message Format](#commit-message-format).

### Default rules matching

- Commits with a `BREAKING CHANGE:` footer will be associated with a major release.
- Commits with type `feat` will be associated with a minor release.
- Commits with type `fix` will be associated with a patch release.
- Commits with type `perf` will be associated with a patch release.

*(**TODO**: use [releaseRules attribute](https://github.com/semantic-release/commit-analyzer#releaserules) to create custom rules)*

## Manage releases

### Process to release
- Update the version in `dbt_project.yml`
- Create a commit following [Conventional commit](#conventional-commit)
- Push your commits and create a PR
- The release pipeline will run when the PR is merged

### Process to delete a release
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

## Useful links
- [Github docs | Managing releases in a repository](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository)