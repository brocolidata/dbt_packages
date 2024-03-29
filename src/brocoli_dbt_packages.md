# Create a brocoli dbt package

## Table of Contents
* [Process to add a dbt project](#process-to-add-a-dbt-project)
* [Create a dbt project](#create-a-dbt-project)
* [Lint `.sql` files with SQLFluff](#lint-sql-files-with-sqlfluff)
+ [SQLFluff CLI](#sqlfluff-cli)
* [Synchronize `dbt_packages` & `dataplatform_functions`](#synchronize-dbt_packages--dataplatform_functions)

## Process to add a dbt project

1. [Create a dbt project](#create-a-dbt-project)
2. [Update CI/CD pipelines](/.github/workflows/CI_CD_pipelines.md#update-cicd-pipelines)


## Create a dbt project
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

4. Your project is ready for development ! You can follow instructions in [dbt Style Guide](src/dbt_style_guide.md) to develop your dbt models.

## Lint `.sql` files with SQLFluff

SQLFluff will auto-fix most SQL linting errors, allowing you to focus your time on what matters.

There are 2 ways of using SQLFluff : 
- `lint` : Show *all* linting violations
- `fix` : Fix *some* linting violations. 

The `[CI] Lint dbt models` GitHub Action will run SQLFluff and annotate any (re)opened/edited Pull Request adding/modifing `.sql` files. *For this to the happen, you must [Update CI/CD pipelines](/.github/workflows/CI_CD_pipelines.md#update-cicd-pipelines) to mention the dbt project with the added/modified `.sql` files*

All SQLFluff linting rules are listed in [SQLFluff Docs | Rules Reference](https://docs.sqlfluff.com/en/stable/rules.html) ; you can also see if a `rule is sqlfluff fix compatible`.


### SQLFluff CLI
All SQLFLuff commands follow this pattern :  
```
sqlfluff COMMAND PATH
```
Substitutions :
- `PATH` by either `models/` (to lint all the project models) or the path to a model or directory of models
- `COMMAND` by either :
  - `lint` (`sqlfluff lint PATH`)
  - `fix` (`sqlfluff fix PATH` or `sqlfluff fix -f PATH` to skip confirmation)

**Lint from outside the remote dev container**
Make sure you are in the root folder and run the [Basic SQLFluff](#basic-sqlfluff-commands) commands prefixed by 
```
docker compose run -w /src/DBT_PROJECT_NAME dbt_packages
```
Substitutions :
- `DBT_PROJECT_NAME` by the name of the dbt project folder

Examples : 
```
docker compose run -w /src/fuel dbt_packages sqlfluff fix -f models/
```

## Synchronize `dbt_packages` & `dataplatform_functions`
```mermaid
flowchart LR
    pro2 --> pro1
    pro3 --> pro1
    p2 --> p1
    p3 --> p1
    subgraph dataplatform_functions
        pro1[dbt_project.yml]
        p1[packages.yml]
    end
    subgraph dbt_packages
        subgraph package1
            pro2[dbt_project.yml]
            p2[packages.yml]
        end
        subgraph package2
            pro3[dbt_project.yml]
            p3[packages.yml]
        end
    end

```
When you create/update a dbt package, you must make sure : 
- The dbt version used to develop the modified dbt packages satisfies the requirement defined in `require-dbt-version` field in the `dbt_project.yml` of the goblet `dbt_functions` in `dataplatform_functions`
- The versions of the dbt packages defined in `packages.yml` are compliant with the ones in `packages.yml` of the goblet `dbt_functions` in `dataplatform_functions`