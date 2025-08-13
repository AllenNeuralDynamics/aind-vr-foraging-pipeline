# aind-vr-foraging-pipeline
This [pipeline](https://codeocean.allenneuraldynamics.org/capsule/5950376/tree) processes data for the VR Foraging task with nextflow. More details on the task can be found at the repository [Aind.Behavior.VRForaging](https://github.com/AllenNeuralDynamics/Aind.Behavior.VrForaging). 

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

The json files follow the metadata schema defined [here](https://github.com/AllenNeuralDynamics/aind-data-schema). The relevant folder to look at for this pipeline is the **`behavior`** folder. **A data contract is provided that has relevant hardware lines and data that will get parsed and packaged into a NWB file from the behavior folder**. More information and an example of a data contract can be found [here](https://allenneuraldynamics.github.io/Aind.Behavior.VrForaging/dataset.html).

Using this structure allows for potentially anyone who has a similar hardware setup to supply a similar data contract and be able to process and package it.

### Pipeline Steps
There are currently 5 steps in the pipeline, some of which run simultaneously. They are listed below:

* [Primary Data NWB Packaging](https://github.com/AllenNeuralDynamics/aind-vr-foraging-primary-data-nwb-packaging): This step ingests the input data with the data contract and packages the raw hardware signals and data into a NWB file to use downstream. All data is added to the **`acquisition`** module of the NWB.
* [Primary Data QC](https://github.com/AllenNeuralDynamics/aind-vr-foraging-primary-qc): This steps ingets the input data with the data contract and outputs qc images, metrics, on hardware signals. The output here are figures, and a **`quality_control.json`** that follows the metadata schema linked above.
* [Processed Data NWB Packaging](https://github.com/AllenNeuralDynamics/aind-vr-forgaging-processing-nwb-packaging): This steps takes the output from the primary data NWB packaging and appends to the NWB file. Mainly, the running encoder data is filtered, and a table is generated for relevant events with their timestamps that occured during the task. See readme for details on processed NWB output
* [Processed Data QC](https://github.com/AllenNeuralDynamics/aind-vr-foraging-processing-qc): This step takes the **`processed NWB and primary data quality_control.json`** as input and outputs figures on task-specific qc, and a combined `quality_control.json` containing both primary qc, and processed qc. See readme for details
* [Metadata aggregator](https://github.com/AllenNeuralDynamics/aind-pipeline-processing-metadata-aggregator). This steps takes in the input data and outputs the updated json files following the metadata schema

### Pipeline Outputs
The pipeline currently outputs the following - the zarr NWB file, qc images, and json files following the metadata schema:

```
📂 behavior_subjectID_YYYY-MM-DD_HH-M-S_processed_YYYY-MM-DD_HH-M-S
├── 🖼️ CameraTestSuite_test_histogram_and_create_asset_5f15aa74edb34f33ad57b9f8ad52ffec.png
├── 🖼️ CameraTestSuite_test_histogram_and_create_asset_b327cb8093a046708f01f559bfcc12f2.png
├── 🖼️ CameraTestSuite_test_histogram_and_create_asset_eb04c4d54cb740eabfe00fa58fcceb90.png
├── 🖼️ HarpSniffDetectorTestSuite_test_sniff_detector_physiology_7175620e05ce496197174540704130dc.png
├── 📂 behavior_subjectID_YYYY-MM-DD_HH-M-S_nwb-processed.zarr
│   ├── 📄 .zattrs
│   ├── 📄 .zgroup
│   ├── 📄 .zmetadata
│   ├── 📂 acquisition
│   ├── 📂 analysis
│   ├── 📂 events
│   ├── 📂 file_create_date
│   ├── 📂 general
│   ├── 📂 identifier
│   ├── 📂 processing
│   ├── 📂 session_description
│   ├── 📂 session_start_time
│   ├── 📂 specifications
│   ├── 📂 stimulus
│   └── 📂 timestamps_reference_time
├── 📄 data_description.json
├── 📄 data_process.json
├── 🖼️ environment_Humidity.png
├── 🖼️ environment_Temperature.png
├── 🖼️ inter_licks_distribution.png
├── 🖼️ licks.png
├── 📄 output
├── 📄 procedures.json
├── 📄 processing.json
├── 📄 quality_control.json
├── 📄 rig.json
├── 📄 session.json
└── 📄 subject.json

```




