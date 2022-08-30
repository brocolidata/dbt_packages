# CI/CD pipelines

This README explains how to manage [Github Actions](https://github.com/features/actions). 

## List of GitHub Actions

| GitHub Action name                                 | Description                 |
|----------------------------------------------------|-----------------------------|
| [[CI] Lint dbt models](dbt_validation_CI.yml)      | Validation of dbt projects  |
| [[CD] Release dbt packages](dbt_validation_CI.yml) | Creation of GitHub Releases |

You can find all the pipelines in the [Actions section of the GitHub repository](https://github.com/brocolidata/dbt_packages/actions)


## Prerequisites

### Create the following GitHub secrets
- **BACK_PROJECT_ID** : Back GCP project ID
- **FRONT_PROJECT_ID** : Front GCP project ID
- **GOOGLE_CREDENTIALS** : a service account json
- **GCP_REGION** : Region of the project

### Location of the `.yml` file for the pipelines
**All the `.yml` files for CI/CD pipelines must be located in the `/.github/workflows` directory**

## Update CI/CD pipelines
Here are the places where code should be added/deleted when a dbt project is added/deleted :

*In `.github/worklfows/dbt_validation_CI.yml` :*
- update `jobs.changes.outputs` (2 lines to add)
- update the `Filter updated dbt projects` (2 lines to add)

*In `.github/worklfows/release_CD.yml` :*
- update `jobs.changes.outputs` (2 lines to add)
- update the `Filter updated dbt projects` (2 lines to add)
[hello](#update-cicd-pipelines)
