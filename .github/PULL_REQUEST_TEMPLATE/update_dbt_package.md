# Update a dbt package

## Description

Describe the update.

Fixes # (issue)

## Scope
- [ ] adventure_works
- [ ] currencies
- [ ] freight

## Type of change

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

# Checklist:

- [ ] I have run `sqlfluff` to lint the models of the modified dbt packages
- [ ] I have run the models of the modified dbt packages either in a local or a test environment
- I have [Synchronized the updated dbt packages with `dataplatform_functions`](/src/brocoli_dbt_packages.md#synchronize-dbt_packages--dataplatform_functions)
- [ ] If the modified dbt packages have been renamed or deleted, I have [updated CI/CD pipelines](/.github/workflows/CI_CD_pipelines.md#update-cicd-pipelines) to update/remove them
- [ ] If the modified dbt packages have been renamed or deleted, I have updated/deleted my dbt package in the list of packages in [Scope section of the *Update dbt package* PR template](/.github/PULL_REQUEST_TEMPLATE/update_dbt_package.md#scope)
- [ ] My modifications are compliant with [Brocoli dbt packages standards](/src/brocoli_dbt_packages.md) & [Brocoli dbt styleguide](/src/dbt_style_guide.md)
- [ ] My project doesn't introduce any breaking change OR any dependent changes have been merged