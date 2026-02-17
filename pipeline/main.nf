#!/usr/bin/env nextflow
// hash:sha256:c1bf900e2f634c868f3ae9ad9448032c2543e4e68943d3fcf34d68e90bf2a2ba

// capsule - primary-nwb-packaging-vr-foraging
process capsule_primary_nwb_packaging_vr_foraging_2 {
	tag 'capsule-7841426'
	container "$REGISTRY_HOST/published/37fe4bfc-5044-44cc-9270-0274a49050fe:v7"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/.*\\.nwb\\.zarr") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*.nwb.zarr'
	path 'capsule/results/*.json', emit: to_capsule_aind_pipeline_processing_metadata_aggregator_20_6_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=37fe4bfc-5044-44cc-9270-0274a49050fe
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
	else
		git -c credential.helper= clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - primary-qc-vr-foraging
process capsule_primary_qc_vr_foraging_1 {
	tag 'capsule-1600699'
	container "$REGISTRY_HOST/published/7486e654-3418-4050-ab38-11ff637bec9b:v7"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7486e654-3418-4050-ab38-11ff637bec9b
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
	else
		git -c credential.helper= clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
	fi
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
	path 'capsule/data'

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
	vr_foraging_raw_to_primary_qc_vr_foraging_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_2_0_4 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')

	// run processes
	capsule_primary_nwb_packaging_vr_foraging_2(vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2.collect())
	capsule_primary_qc_vr_foraging_1(vr_foraging_raw_to_primary_qc_vr_foraging_1.collect())
	capsule_aind_pipeline_processing_metadata_aggregator_20_6(capsule_primary_nwb_packaging_vr_foraging_2.out.to_capsule_aind_pipeline_processing_metadata_aggregator_20_6_3.collect(), vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_2_0_4.collect())
}
