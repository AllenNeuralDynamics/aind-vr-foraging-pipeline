# aind-vr-foraging-pipeline
This [pipeline](https://codeocean.allenneuraldynamics.org/capsule/5950376/tree) processes data for the VR Foraging task with nextflow. More details on the task can be found at the repository [Aind.Behavior.VRForaging](https://github.com/AllenNeuralDynamics/Aind.Behavior.VrForaging). It is compatible with task versions >= 0.3. All packaging/processing code is done in an external library - see details below.

### Pipeline Inputs
The input to the pipeline is data structured in the following format. At the top level, the directory and files are as follows:

```
📂 behavior_subjectID_YYYY-MM-DD_HH-M-S
├── 📂 behavior
├── 📂 behavior-videos
├── 📄 session.json
├── 📄 subject.json
├── 📄 data_description.json
├── 📄 metadata.nd.json
├── 📄 procedures.json
├── 📄 processing.json
└── 📄 rig.json

```

The json files follow the metadata schema defined [here](https://github.com/AllenNeuralDynamics/aind-data-schema). The relevant folder to look at for this pipeline is the **`behavior`** folder. This pipeline ONLY processes data from it

### Pipeline Steps
There are currently 3 steps in the pipeline, some of which run simultaneously. They are listed below:

* [Primary Data NWB Packaging](https://github.com/AllenNeuralDynamics/aind-vr-foraging-primary-data-nwb-packaging): This steps uses this [library](https://github.com/AllenNeuralDynamics/Aind.Behavior.VrForaging.Packaging) and is just a thin wrapper over it. All issues should be opened on the library and then this capsule will just update the version and any minor updates as needed.
* [Primary Data QC](https://github.com/AllenNeuralDynamics/aind-vr-foraging-primary-qc): This steps ingets the input data and outputs qc images, metrics, on hardware signals. The output here are artifacts, and a **`quality_control.json`** that follows the metadata schema linked above.
* [Metadata aggregator](https://github.com/AllenNeuralDynamics/aind-pipeline-processing-metadata-aggregator). This steps takes in the input data and outputs the updated json files following the metadata schema

### Pipeline Outputs
The pipeline currently outputs the following - the zarr NWB file, session level parquet files and aind valid metadata. 




