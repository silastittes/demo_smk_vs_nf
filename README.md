Simple demo repo for lab meeting to showcase basics of and differences between Nextflow and Snakemake


## Build and load env

```
mamba env create -f workflow_env.yml
mamba activate workflow_env
```

## Example commands

```bash
# looks for ~/.config/snakemake/talapas/config.yaml
snakemake --workflow-profile ~/.config/snakemake/talapas/

# force re-run
snakemake --workflow-profile ~/.config/snakemake/talapas/ -F
```

```bash
# looks for ~/.nextflow/config
nextflow run main.nf -profile cluster

# using local config file
nextflow run main.nf -config nextflow.config -profile cluster

# using cached results (equivalent to snakemake's default)
nextflow run main.nf -config nextflow.config -profile cluster -resume

# using gpu profile
nextflow run main.nf -config nextflow.config -profile cluster_gpu -resume
```