#!/usr/bin/env nextflow
// hash:sha256:16f54f1485b9df2219c80d5521dcc0304f5ba1a1d83ab4be3e7e7e09c7a31e06

// capsule - primary-nwb-packaging-vr-foraging
process capsule_primary_nwb_packaging_vr_foraging_2 {
	tag 'capsule-7841426'
	container "$REGISTRY_HOST/published/37fe4bfc-5044-44cc-9270-0274a49050fe:v12"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/vr_foraging_raw'

	output:
	path 'capsule/results/*'
	path 'capsule/results/*.json', emit: to_capsule_aind_metadata_manager_capsule_6_3

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
		git -c credential.helper= clone --filter=tree:0 --branch v12.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
	else
		git -c credential.helper= clone --branch v12.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7841426.git" capsule-repo
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
	container "$REGISTRY_HOST/published/7486e654-3418-4050-ab38-11ff637bec9b:v10"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

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
		git -c credential.helper= clone --filter=tree:0 --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
	else
		git -c credential.helper= clone --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1600699.git" capsule-repo
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

// capsule - aind-metadata-manager-capsule
process capsule_aind_metadata_manager_capsule_6 {
	tag 'capsule-8324994'
	container "$REGISTRY_HOST/published/22261566-0b4f-42aa-bcaa-58efa55bf653:v4"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'
	path 'capsule/data'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=22261566-0b4f-42aa-bcaa-58efa55bf653
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8324994.git" capsule-repo
	else
		git -c credential.helper= clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8324994.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_metadata_manager_capsule_6_args}

	echo "[${task.tag}] completed!"
	"""
}

params.vr_foraging_raw_url = 's3://aind-open-data/863680_2026-08-22_17-46-40'

workflow {
	// input data
	vr_foraging_raw_to_primary_qc_vr_foraging_1 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')
	vr_foraging_raw_to_aind_metadata_manager_capsule_4 = Channel.fromPath(params.vr_foraging_raw_url + "/", type: 'any')

	// run processes
	capsule_primary_nwb_packaging_vr_foraging_2(vr_foraging_raw_to_primary_nwb_packaging_vr_foraging_2.collect())
	capsule_primary_qc_vr_foraging_1(vr_foraging_raw_to_primary_qc_vr_foraging_1.collect())
	capsule_aind_metadata_manager_capsule_6(capsule_primary_nwb_packaging_vr_foraging_2.out.to_capsule_aind_metadata_manager_capsule_6_3.collect(), vr_foraging_raw_to_aind_metadata_manager_capsule_4.collect())
}
