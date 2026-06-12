Flutter Analysis - Tuned System
Octave was used for the validation of flutter generation conditions

#===================================================================================#

Validation based on methods presented by Kaza & Kielb (1981) and Whitehead (1960)

The papers can be found here:
Kaza & Kielb (1981): https://doi.org/10.2514/6.1981-602
Whitehead (1960): https://reports.aerade.cranfield.ac.uk/handle/1826.2/3828

The scripts outlined calculate and plot tuned system mode eigenvalues for a rotor.
The main function is: TunedSystemMode_TUFRG(r,N) where,
	- N is the number of blades
	- r is the nodal diameter / mode number
	
The function returns a complex eigenvalue result for the bending and torsional modes

#===================================================================================#

Functions

TunedSystemMode_TUFRG.m
	- Main function used to calculate tuned system mode eigenvalues
	- Contains blade geometry, material properties, structural properties, and 
	  aerodynamic inputs
	- Values in this function can be changes to represent the blade geometry 
	  being studied
	  
main_graphFlutter.m
	- This script calculates the tuned system modes for a single rotor
	- Input the number of blades, N, dependent on rotor geometry
		- ex. N = 19;
	- Two plots output:
		- Bending mode eigenvalues
		- Torsional mode eigenvalues
	- Each plot shows the real part of the eigenvalue on the x-axis and the 
	  imaginary part on the y-axis.
	  
main_graphMultipleBladeConfigs.m
	- This script allows for tuned system modes of different blade counts to be 
	  compared
	- Input number of blades, N, for multiple rotor geometries
		- ex. N = [19 25];
	- The script calculates the tuned system modes for each value of N and plots 
	  them on the same figure.
	- Two plots output:
		- Bending mode eigenvalues
		- Torsional mode eigenvalues
	- Use this script when comparing different blade counts

#===================================================================================#

How to use

1. Place all MATLAB files in the same folder (*.m)
	- main_graphFlutter.m
	- main_graphMultipleBladeConfigs.m
	- TunedSystemMode_TUFRG.m
	- GeneralAxisCoefficents.m
	- KazaATuned.m
	- KazaDTuned.m
	- KazaETuned.m
	- KazaGTuned.m
	- WhiteheadA.m
	- WhiteheadAV2.m
	- WhiteheadB.m
	- WhiteheadGamma.m
	- WhiteheadX.m
	
2. Open MATLAB or Octave and set the working directory to where the files are located

3. Set the parameters of your system if needed
	- TunedSystemMode_TUFRG.m

4. Run the desired plotting script, set N as required
	- main_graphFlutter.m for single rotor analysis
	- main_graphMultipleBladeConfigs.m for rotor comparison
	
#===================================================================================#
