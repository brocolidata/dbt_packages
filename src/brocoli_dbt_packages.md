# Create a brocoli dbt package

## Process to add a dbt project

### 1. [Process to create a dbt project](#process-to-create-a-dbt-project)

### 2. [Update CI/CD pipelines](/.github/workflows/CI_CD_pipelines.md#update-cicd-pipelines)



## Process to create a dbt project
1. Make sure you are in `/src` folder and run `dbt init` then follow the steps to create a skeleton for your dbt project.
2. Create a file named `.releaserc` in the root folder created by the previous command and with the following code :
  
    Replace the following placeholders : 
    *  `SHORT` by the name or an abbreviation of your dbt project
```
{
    "branches": [
        "main"
    ],
    "tagFormat":"SHORT_v_${version}",
    "plugins": [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        "semantic-release-export-data"
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
profile = my-bigquery-db
target = prod

```