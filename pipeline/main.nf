#!/usr/bin/env nextflow
// hash:sha256:7f93ce51c67900f4a3b2a7307b3e015a772bdc6e1e4f80b8b84d61db40cfcc37

// capsule - aind-vr-foraging-primary-qc
process capsule_aind_vr_foraging_primary_qc_1 {
	tag 'capsule-2349123'
	container "$REGISTRY_HOST/capsule/6e6b5a5d-2f83-48db-a10d-b7a5eb42e1fc"

	cpus 1
	memory '7.5 GB'

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
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

workflow {
	// run processes
	capsule_aind_vr_foraging_primary_qc_1()
}
