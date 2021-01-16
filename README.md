# Chest Compression Detection Demo
Demonstration of chest compression detection using the transthoracic impedance signal. The core functions are obfuscated. 

# Citation

Coult J, Blackwood J, Rea T, Kudenchuk P, Kwok H. A Method to Detect
Presence of Chest Compressions during Resuscitation using Transthoracic
Impedance. IEEE Journal of Biomedical and Health Informatics, vol. 24, no.
3, March 2020. https://doi.org/10.1109/JBHI.2019.2918790

# Setup
Download and run all in a folder using MATLAB. Program was written using MATLAB 2019a. 

# How to Run
Run the main_Demo.m script to run the demo which loads and processes the example data to produce outputs. 

# Output Figures
The output figures show the predicted scores and binary outputs for presence of CPR using 3.2-second and 5-second input lengths, and should match the figure images in the figures folder. The figures plot the chest impedance signals (which are analyzed in the detector) along with the ventricular fibrillation ECGs concurrent with the chest impedance (which are not used in the analysis and are for illustration only). 

# Data
Data folder contains deidentified 5-second ECG and Impedance segments. Data is from Lifepak 12, Lifepak 15, Heartstart MRx, and Forerunner 3 automated biphasic defibrillators. 

# Preprocessing
All required preprocessing is performed in the code.

