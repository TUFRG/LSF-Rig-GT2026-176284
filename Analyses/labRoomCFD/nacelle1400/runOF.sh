#!/bin/bash
# This bash script initailizes the OpenFOAM steady computation using simpleFOAM
# The operating conditions for this case are defined by the operating flow rate of the LSF rig

# This script is intended to be run in a directory that contains the folders 'caseSetup' after completing the mesh

# Number of cores to run the parallel computations on. Modify as needed.
numCores=380

set -e

# 1. Create run case directory
mkdir lsf_runCase
mkdir lsf_runCase/0
mkdir lsf_runCase/constant
mkdir lsf_runCase/system

# Copy mesh data into run case folder
cp -r caseSetup/constant/polyMesh lsf_runCase/constant/

cd lsf_runCase



# 2. simpleFoam
# Copy over required files
cp -r ../caseSetup/0/* 0/
cp -r ../caseSetup/constant/* constant/
cp -r ../caseSetup/system/* system/


# Modify the number of cores to decompose
sed -i 's,numberOfSubdomains.*,numberOfSubdomains '"$numCores"';,' system/decomposeParDict

# Decompose case
decomposePar

# Run potentialFoam
mpirun -np $numCores simpleFoam -parallel























