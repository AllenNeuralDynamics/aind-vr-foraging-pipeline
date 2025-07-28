#!/usr/bin/env nextflow
// hash:sha256:fe21faa049271822503250778e1241cbbaa4d287470aa9664cf94af6076e4cad

// capsule - aind-pipeline-processing-metadata-aggregator
process capsule_aind_pipeline_processing_metadata_aggregator_3 {
	tag 'capsule-0249670'
	container "$REGISTRY_HOST/capsule/2b968496-f5cd-47ce-b2ec-3c9d48c73a14:bd71a7af034314ca5a9719efd9c39421"

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

	export CO_CAPSULE_ID=2b968496-f5cd-47ce-b2ec-3c9d48c73a14
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0249670.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0249670.git" capsule-repo
	fi
	git -C capsule-repo checkout 51fbabccca89050e39b674dd1270f00d4977d6bf --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-vr-foraging-primary-qc
process capsule_aind_vr_foraging_primary_qc_1 {
	tag 'capsule-2349123'
	container "$REGISTRY_HOST/capsule/6e6b5a5d-2f83-48db-a10d-b7a5eb42e1fc:2317daf65f39298eb11e89609f31203c"

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
	container "$REGISTRY_HOST/capsule/51b7989c-8f37-4546-b936-a15e48ea8425:b47a46f0c29713d32e397392ef40133f"

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
	git -C capsule-repo checkout c5ea0dbaeffb6133f64cace7c94a5fc4ba54b56a --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

params.vr_foraging_raw_url = 's3://aind-private-data-prod-o5171v/behavior_789923_2025-05-13_16-16-16'

workflow {
	// input data
	vr_foraging_raw_to_aind_vr_foraging_primary_qc_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_aind_vr_foraging_primary_data_nwb_packaging_2 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_3 = Channel.fromPath(params.vr_foraging_raw_url + "/*.json", type: 'any')

	// run processes
	capsule_aind_pipeline_processing_metadata_aggregator_3(vr_foraging_raw_to_aind_pipeline_processing_metadata_aggregator_3.collect())
	capsule_aind_vr_foraging_primary_qc_1(vr_foraging_raw_to_aind_vr_foraging_primary_qc_1.collect())
	capsule_vr_foraging_primary_data_nwb_packaging_2(vr_foraging_raw_to_aind_vr_foraging_primary_data_nwb_packaging_2.collect())
}
