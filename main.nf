#!/usr/bin/env nextflow

//#example pipeline to make some files from seeds and consolidate the output. Very common tasks for our ilk 

// Read values from file
value_channel = channel.fromPath('seeds.txt')
    .splitCsv(header: true)
    .map { row -> tuple(row.seeds, row.test) }

// Define the output directory
params.outdir = 'NF_output'

// Define the process
process generate_output {
    //publishDir params.outdir, mode: 'copy'
    publishDir "${params.outdir}/seed_${seed}", mode: 'copy'

    input:
    tuple val(seed), val(test)

    output:
    path("output_seed_${seed}.txt"), emit: results

    script:
    """
    python $baseDir/take_inputs.py -o output_seed_${seed}.txt -s ${seed}
    """
}

// try PWD maybe?
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
    // Run the process for each value
    output_files = generate_output(value_channel)
    // Collect the output
    collect_output(output_files.collect())
}