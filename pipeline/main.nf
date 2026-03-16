#!/usr/bin/env nextflow
// hash:sha256:31f6d95ddf10750b595bf82f5e41d434cb3d55efafaeb0802c6cc107c37256ec

// capsule - primary-nwb-packaging-vr-foraging
process capsule_primary_nwb_packaging_vr_foraging_2 {
	tag 'capsule-3265591'
	container "$REGISTRY_HOST/capsule/51b7989c-8f37-4546-b936-a15e48ea8425:958866e7dd69a688433614f9267ae877"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/.*\\.nwb\\.zarr") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*.nwb.zarr'
	path 'capsule/results/*.json', emit: to_capsule_aind_pipeline_processing_metadata_aggregator_20_6_2

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=51b7989c-8f37-4546-b936-a15e48ea8425
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3265591.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3265591.git" capsule-repo
	fi
	git -C capsule-repo checkout 884dcddd7e5037ab214fafc105312cfa41bc65f8 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-pipeline-processing-metadata-aggregator_2.0
process capsule_aind_pipeline_processing_metadata_aggregator_20_6 {
	tag 'capsule-8464459'
	container "$REGISTRY_HOST/published/278c12cc-fb64-4399-88cf-8bc3e6db6dc2:v1"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=278c12cc-fb64-4399-88cf-8bc3e6db6dc2
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8464459.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8464459.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_20_6_args}

	echo "[${task.tag}] completed!"
	"""
}

params.vr_foraging_raw_url = 's3://aind-open-data/804430_2025-10-30_23-15-07'

workflow {
	// input data
	vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')

	// run processes
	capsule_primary_nwb_packaging_vr_foraging_2(vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_1.collect())
	capsule_aind_pipeline_processing_metadata_aggregator_20_6(capsule_primary_nwb_packaging_vr_foraging_2.out.to_capsule_aind_pipeline_processing_metadata_aggregator_20_6_2.collect())
}
