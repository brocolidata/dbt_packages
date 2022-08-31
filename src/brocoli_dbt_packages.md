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

## Lint `.sql` files with SQLFluff
There are 2 ways of using SQLFluff : 
- `lint` : Show linting violations
- `fix` : Fix linting violations

### Basic SQLFluff commands
*Make sure you are inside the remote dev container & `cd` in the dbt project you want to lint*
- **Command pattern** : `sqlfluff COMMAND PATH`

  Substitutions :
  - `COMMAND` by either `fix` or `lint`)*
  - `PATH` by either `models/` (to lint all the project models) or the path to a model or directory of models
- `lint` : run `sqlfluff lint PATH`
- `fix` : run `sqlfluff fix PATH` (you can add `-f`between `fix` & `PATG` to skip confirmation)

### From outside the remote dev container
Make sure you are in the root folder and run the [Basic SQLFluff](#basic-sqlfluff-commands) prefixed by 
```
docker compose run -w /src/DBT_PROJECT_NAME dbt_packages
```
  Substitutions :
  - `DBT_PROJECT_NAME` by the name of the dbt project folder

  Examples : 
  ```
  docker compose run -w /src/fuel dbt_packages sqlfluff fix -f models/
  ```
