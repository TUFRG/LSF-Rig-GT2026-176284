Case Overview

	This CFD case models a 1/6 sector of a plenum geometry for a Low Speed Fan (LSF) rig.
	The purpose of the simulation is to evaluate the flow through the plenum section and evaluate pressure loss produced by the system.
	The geometry includes the annular inlet section with hub and casing radii, the plenum chamber, and the downstream outlet ducting. 
	The case is solved using steady-state incompressible RANS CFD in OpenFOAM.
	The results of this case are used to determine whether the plenum induces any upstream influence on the rig and pressure loss on the system.


Geometry

	The geometry of the plenum sector was completed in Autodesk Inventor 2024 and is comprised of 9 surfaces. STL files were generated to be used for mesh creation.
	These surfaces include an inlet, hub, casing, frontHex (front wall), topHex (top wall), rearHex (rearWall), wallsA (side walls), outflowPipe, and outlet.
	A symmetry condition is applied the wallsA as the plenum would extend past these faces. 
	All other face boundarys are set as wall.
 
Mesh
 
	To create computational mesh for domain:
 
		Run 'cartesianMesh'
 
			- a general cell size of 0.003 was used
			- a box refinement was created at the plenum and casing connection
			to fix non-orthogonal cells

OpenFOAM Computation

	To decompose mesh:

		Run 'decomposePar'

			- number of subdomains can be edited in decomposeParDict

	To initiate simulation:

		Run 'mpirun -np 30 simpleFoam -parallel'

			- the number before simpleFoam should be equal to the number of decomposed directories
			- the initial case will run with inlet veloctity and zeroGradient pressure on inlet

	To apply changes in changeDictionaryDict:

		Run 'changeDictionary' 

			-this will make the case run with an inlet uniform pressure

	To reconstruct case:

		Run 'reconstructPar'
