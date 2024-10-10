#!/usr/bin/env nextflow

//#example pipeline to make some files from seeds and consolidate the output. Very common tasks for our ilk 

// Read values from file
value_channel = channel.fromPath('seeds.txt')
    .splitCsv(header: true)
    .map { row -> row.seeds}

// Define the output directory
// "params" can be overridden by command line arguments
params.outdir = 'NF_output'

// Define the process
process generate_output {
    // Copy out of the work directory (can symlink or other options too)
    publishDir "${params.outdir}/seed_${seed}", mode: 'copy'

    input:
        val(seed)
    output:
        path("output_seed_${seed}.txt")
    script:
        """
        python $baseDir/take_inputs.py -o output_seed_${seed}.txt -s ${seed}
        """
}

process collect_output {
    publishDir "${params.outdir}", mode: 'copy'

    input:
        path(x)
    output:
        path 'NF_combined_output.txt'
    script:
        """
        cat ${x} > NF_combined_output.txt
        """
}

workflow {
    output_files = generate_output(value_channel)
    collect_output(output_files.collect())
}