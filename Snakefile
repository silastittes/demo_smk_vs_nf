#example pipeline to make some files from seeds and consolidate the output. Very common tasks for our ilk 
import numpy as np
rng = np.random.default_rng(42)
n_sims = 10
seeds = rng.integers(0, 1e18, n_sims)

rule all:
    input: 
        [f"smk_output/seed_{seed}/output.txt" for seed in seeds],
        "smk_output/combined_output.txt"

rule generate_output:
    output:
        "smk_output/seed_{seed}/output.txt"
    shell:
        """
        python take_inputs.py -o {output} -s {wildcards.seed}
        """

rule collect_output:
    input:
        expand("smk_output/seed_{seed}/output.txt", seed=seeds)
    output:
        "smk_output/combined_output.txt"
    shell:
        """
        cat {input} > {output}
        """