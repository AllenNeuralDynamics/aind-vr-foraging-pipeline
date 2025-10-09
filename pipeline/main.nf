#!/usr/bin/env nextflow
// hash:sha256:3517997e905a04d27e628db8a98df91eb417445df2a61e44ade435ebb970e127

// capsule - primary-nwb-packaging-vr-foraging
process capsule_primary_nwb_packaging_vr_foraging_2 {
	tag 'capsule-7841426'
	container "$REGISTRY_HOST/published/37fe4bfc-5044-44cc-9270-0274a49050fe:v2"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*', emit: to_capsule_processing_nwb_packaging_vr_foraging_4_5

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
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
	container "$REGISTRY_HOST/published/7486e654-3418-4050-ab38-11ff637bec9b:v2"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/.*\\.png") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*.png'
	path 'capsule/results/quality_control.json', emit: to_capsule_processing_qc_vr_foraging_5_6

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
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

// capsule - processing-nwb-packaging-vr-foraging
process capsule_processing_nwb_packaging_vr_foraging_4 {
	tag 'capsule-3664899'
	container "$REGISTRY_HOST/published/615eb7a0-d882-4705-a5c8-f267c18d3747:v2"

	cpus 4
	memory '30 GB'

	cache 'deep'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'
	path 'capsule/data/'
	path 'capsule/data/vr_foraging_raw_nwb/'

	output:
	path 'capsule/results/*'
	path 'capsule/results/*', emit: to_capsule_processing_qc_vr_foraging_5_7
	path 'capsule/results/*.json', emit: to_capsule_aind_pipeline_processing_metadata_aggregator_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=615eb7a0-d882-4705-a5c8-f267c18d3747
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3664899.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3664899.git" capsule-repo
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

// capsule - aind-pipeline-processing-metadata-aggregator
process capsule_aind_pipeline_processing_metadata_aggregator_6 {
	tag 'capsule-8250608'
	container "$REGISTRY_HOST/published/d51df783-d892-4304-a129-238a9baea72a:v5"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data'
	path 'capsule/data/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d51df783-d892-4304-a129-238a9baea72a
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8250608.git" capsule-repo
	else
		git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8250608.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_6_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - processing-qc-vr-foraging
process capsule_processing_qc_vr_foraging_5 {
	tag 'capsule-0042488'
	container "$REGISTRY_HOST/published/7e1328ac-d888-46db-a433-09489299a35b:v2"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/raw_qc.json'
	path 'capsule/data/vr_foraging_processed_nwb/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7e1328ac-d888-46db-a433-09489299a35b
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0042488.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0042488.git" capsule-repo
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

params.vr_foraging_raw_url = 's3://aind-private-data-prod-o5171v/behavior_789924_2025-06-25_18-35-44'

workflow {
	// input data
	vr_foraging_raw_to_primary_qc_vr_foraging_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	hardware_mapping_to_processing_nwb_packaging_vr_foraging_3 = Channel.fromPath("../data/hardware_mapping/*", type: 'any')
	hed_tag_mapping_to_processing_nwb_packaging_vr_foraging_4 = Channel.fromPath("../data/hed_tag_mapping/*", type: 'any')
	vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_8 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')

	// run processes
	capsule_primary_nwb_packaging_vr_foraging_2(vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2.collect())
	capsule_primary_qc_vr_foraging_1(vr_foraging_raw_to_primary_qc_vr_foraging_1.collect())
	capsule_processing_nwb_packaging_vr_foraging_4(hardware_mapping_to_processing_nwb_packaging_vr_foraging_3, hed_tag_mapping_to_processing_nwb_packaging_vr_foraging_4, capsule_primary_nwb_packaging_vr_foraging_2.out.to_capsule_processing_nwb_packaging_vr_foraging_4_5.collect())
	capsule_aind_pipeline_processing_metadata_aggregator_6(vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_8.collect(), capsule_processing_nwb_packaging_vr_foraging_4.out.to_capsule_aind_pipeline_processing_metadata_aggregator_6_9.collect())
	capsule_processing_qc_vr_foraging_5(capsule_primary_qc_vr_foraging_1.out.to_capsule_processing_qc_vr_foraging_5_6, capsule_processing_nwb_packaging_vr_foraging_4.out.to_capsule_processing_qc_vr_foraging_5_7.collect())
}
