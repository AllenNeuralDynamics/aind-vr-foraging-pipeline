#!/usr/bin/env nextflow
// hash:sha256:f3c6ba71c6efccdc89376d9c166e0fc8d2c33e67876d0e32efd134b2f60e41a4

// capsule - aind-vr-foraging-primary-qc
process capsule_aind_vr_foraging_primary_qc_1 {
	tag 'capsule-2349123'
	container "$REGISTRY_HOST/capsule/6e6b5a5d-2f83-48db-a10d-b7a5eb42e1fc:2317daf65f39298eb11e89609f31203c"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/.*\\.png") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*.png'
	path 'capsule/results/quality_control.json', emit: to_capsule_aind_vr_foraging_processing_qc_5_6

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=6e6b5a5d-2f83-48db-a10d-b7a5eb42e1fc
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2349123.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2349123.git" capsule-repo
	fi
	git -C capsule-repo checkout 188b725f83cc085cbf7557c2e106f4d5f53be982 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-vr-foraging-primary-data-nwb-packaging
process capsule_vr_foraging_primary_data_nwb_packaging_2 {
	tag 'capsule-3265591'
	container "$REGISTRY_HOST/capsule/51b7989c-8f37-4546-b936-a15e48ea8425:154c87d64a3601553b393bc8abfda66c"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*', emit: to_capsule_aind_vr_foraging_processing_nwb_packaging_4_5

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3265591.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3265591.git" capsule-repo
	fi
	git -C capsule-repo checkout 534194a6b8fb3df8cadefee2ca895666e2a5674d --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-vr-foraging-processing-nwb-packaging
process capsule_aind_vr_foraging_processing_nwb_packaging_4 {
	tag 'capsule-5107215'
	container "$REGISTRY_HOST/capsule/59376165-6b62-43f8-a4a4-8e16102d6bd0:e88d19ff2dae586165fe6b44b8abaf23"

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
	path 'capsule/results/*', emit: to_capsule_aind_vr_foraging_processing_qc_5_7
	path 'capsule/results/*.json', emit: to_capsule_aind_pipeline_processing_metadata_aggregator_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=59376165-6b62-43f8-a4a4-8e16102d6bd0
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5107215.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5107215.git" capsule-repo
	fi
	git -C capsule-repo checkout a331993d69fc97d17d85cf53718ae33648a16d0c --quiet
	mv capsule-repo/code capsule/code
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
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_6_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-vr-foraging-processing-qc
process capsule_aind_vr_foraging_processing_qc_5 {
	tag 'capsule-3338802'
	container "$REGISTRY_HOST/capsule/2b465a66-8c6b-4abb-a095-3c714039d39a:e60fab5afa6fe96062f7e159ca4c0ad4"

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

	export CO_CAPSULE_ID=2b465a66-8c6b-4abb-a095-3c714039d39a
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3338802.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3338802.git" capsule-repo
	fi
	git -C capsule-repo checkout ee3d55981da1aeb2784dfd93c9521fcacf231ac9 --quiet
	mv capsule-repo/code capsule/code
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
	vr_foraging_raw_to_aind_vr_foraging_primary_qc_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_aind_vr_foraging_primary_data_nwb_packaging_2 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	hardware_mapping_to_aind_vr_foraging_processing_nwb_packaging_3 = Channel.fromPath("../data/hardware_mapping/*", type: 'any')
	hed_tag_mapping_to_aind_vr_foraging_processing_nwb_packaging_4 = Channel.fromPath("../data/hed_tag_mapping/*", type: 'any')
	vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_8 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')

	// run processes
	capsule_aind_vr_foraging_primary_qc_1(vr_foraging_raw_to_aind_vr_foraging_primary_qc_1.collect())
	capsule_vr_foraging_primary_data_nwb_packaging_2(vr_foraging_raw_to_aind_vr_foraging_primary_data_nwb_packaging_2.collect())
	capsule_aind_vr_foraging_processing_nwb_packaging_4(hardware_mapping_to_aind_vr_foraging_processing_nwb_packaging_3, hed_tag_mapping_to_aind_vr_foraging_processing_nwb_packaging_4, capsule_vr_foraging_primary_data_nwb_packaging_2.out.to_capsule_aind_vr_foraging_processing_nwb_packaging_4_5.collect())
	capsule_aind_pipeline_processing_metadata_aggregator_6(vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_8.collect(), capsule_aind_vr_foraging_processing_nwb_packaging_4.out.to_capsule_aind_pipeline_processing_metadata_aggregator_6_9.collect())
	capsule_aind_vr_foraging_processing_qc_5(capsule_aind_vr_foraging_primary_qc_1.out.to_capsule_aind_vr_foraging_processing_qc_5_6, capsule_aind_vr_foraging_processing_nwb_packaging_4.out.to_capsule_aind_vr_foraging_processing_qc_5_7.collect())
}
