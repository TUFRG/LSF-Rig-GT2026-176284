LAB MODEL - Nacelle Configuration
OpenFOAM v2312 was used for the validation of vortex generation conditions

#===================================================================================#

Geometry for this setup is provided, the model was created in Autodesk Inventor 2024 
STL files were generated from this software to be used for mesh creation.

The purpose of this model is to determine if GVI formation occurs with the 
nacelle configuration of the rig at the working height of 1.4m from the ground to the
center axis of the rig.

The case is solved using the simpleFoam steady-state incompressible solver in OpenFOAM

#===================================================================================#

Create computational mesh for OpenFOAM


Run './meshCase.sh'

	- the full domain is created using CFMesh for openfoam
	- cartesianMesh command is used

#===================================================================================#

OpenFOAM computation

run './runOF.sh'

	- This creates a new directory "lsf_runCase" where openFOAM computations 
	  will take place.
	- The script assumes the user wishes to run the computation in parallel 
	  using > 1 cores. The number of cores can be modified in this script.
	- This script initializes the steady computation using the simpleFoam solver
