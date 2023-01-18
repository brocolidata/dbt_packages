# New dbt package

## Description

Fixes # (issue)


# Checklist:

- [ ] I have run `sqlfluff` to lint the models of this dbt package
- [ ] I have run my models either in a local or a test environment
- I have [Synchronized the dbt package with `dataplatform_functions`](/src/brocoli_dbt_packages.md#synchronize-dbt_packages--dataplatform_functions)
- [ ] I have [updated CI/CD pipelines](/.github/workflows/CI_CD_pipelines.md#update-cicd-pipelines) to add my dbt package
- [ ] I have added my dbt package to the list of packages in [Scope section of the *Update dbt package* PR template](/.github/PULL_REQUEST_TEMPLATE/update_dbt_package.md#scope)
- [ ] The dbt package is compliant with [Brocoli dbt packages standards](/src/brocoli_dbt_packages.md) & [Brocoli dbt styleguide](/src/dbt_style_guide.md)
- [ ] My project doesn't introduce any breaking change OR any dependent changes have been merged