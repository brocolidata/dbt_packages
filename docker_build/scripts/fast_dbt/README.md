# Fast dbt
CLI tool that exposes high level APIs to quickly work with dbt in a Brocoli environment

## Setup
### **(re)Install dbt packages**
```
fast_dbt deps
```

## Sources & Staging
### **Refresh sources in `stg.yml`**
```
fast_goblet generate_sources
```

### **Stage unstaged sources**
```
fast_dbt stage_sources
```

### **Generate `.sql`from a source provided as argument**  
*(replace `SOURCE` with your source)*
```
fast_dbt generate_sql SOURCE
```

## Run models
### **Run only model provided as argument**  
*(replace `MODEL` with your model)*
```
fast_dbt run_model MODEL
```

### **Run all models that are chils of a source provided as argument**  
*(replace `SOURCE` with your source)*
```
fast_dbt run_branch SOURCE
```

## Documentation
### **Generate `.yml` files for documenting a table provided as argument**  
*(replace `TABLE` with your table)*
```
fast_dbt generate_sql TABLE
```

### **Deploy a local dbt-docs server**
```
fast_dbt deploy_docs_local
```

### **Deploy dbt-docs to GCS**
```
fast_dbt deploy_docs
```
