#!/bin/bash

PROJECT_PATH="/lustre03/project/6003287"
DATASET_PATH=$1
DATASET_FOLDER="${DATASET_PATH%/*}"
TEMPLATEFLOW_DIR=/home/$USER/.cache/templateflow
PYTHON_CMD="python /fmriprep-slurm/fmriprep-slurm/main.py "$@

echo "Running fmriprep-slurm with singularity"
echo "singularity_run.bash "$@
export SINGULARITYENV_TEMPLATEFLOW_HOME=/templateflow
module load singularity/3.6

echo "Creating templateflow directory in "$TEMPLATEFLOW_DIR
mkdir -p $TEMPLATEFLOW_DIR

echo $PYTHON_CMD | xargs singularity exec -B $PROJECT_PATH/fmriprep-slurm:/fmriprep-slurm \
  -B $DATASET_FOLDER:/DATA -B /etc/pki:/etc/pki \
  -B $TEMPLATEFLOW_DIR:/templateflow \
  $PROJECT_PATH/containers/fmriprep-20.2.1lts.sif
