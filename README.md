# dbt_packages
Repository that contains all dbt packages created by Brocoli Data

## dbt conventions
See : 
- [dbt Style Guide](src/dbt_guide.md)

## Process to add a dbt project

### 1. [Process to create a dbt project](#process-to-create-a-dbt-project)

### 2. Update CI/CD pipelines
*In `.github/worklfows/dbt_validation_CI.yml` :*
- update `jobs.changes.outputs` (2 lines to add)
- update the `Filter updated dbt projects` (2 lines to add)

*In `.github/worklfows/release_CD.yml` :*
- update `jobs.changes.outputs` (2 lines to add)
- update the `Filter updated dbt projects` (2 lines to add)


## Process to create a dbt project
1. Make sure you are in `/src` folder and run `dbt init` then follow the steps to create a skeleton for your dbt project.
2. Create a file named `.releaserc` in the root folder created by the previous command and with the following code :
  
    Replace the following placeholders : 
    *  `SHORT` by an abbreviation of your dbt project name (it can be similar to `LONG_NAME` if the latter is short) 
    * `LONG_NAME` by the name of the dbt project you created in the previous step 
    * `HUMAN NAME` by a long human name for your project (it can be similar to `LONG_NAME`)
```
{
    "branches": [
        "main"
    ],
    "tagFormat":"SHORT_v_${version}",
    "plugins": [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        [
            "@semantic-release/github",
            {
                "assets": [
                    {
                        "path": "src/LONG_NAME/**",
                        "name": "dbt_SHORT_${nextRelease.gitTag}",
                        "label": "dbt HUMAN NAME  (${nextRelease.gitTag})"
                    }
                ]
            }
        ]    
    ]
}
```
3. Create a file named `.sqlfluff` in the root folder created by the previous command and with the following code :
```
[sqlfluff]
templater = dbt
dialect = bigquery
sql_file_exts = .sql

[tool.sqlfluff.templater.jinja]
apply_dbt_builtins = True

[sqlfluff:templater:dbt]
project_dir = .
profiles_dir = ../../profiles
profile = my-bigquery-db
target = prod

```


## Process to update version
- Update the version in `dbt_project.yml`