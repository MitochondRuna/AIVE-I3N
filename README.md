# AIVE-I3N
## Overview
The following macros were developed to run in FIJI ImageJ software version 1.53t. 

The macros can be opened directly in ImageJ and run, or added to the macros folder in your local copy of ImageJ.

The code here represents the adapted version of the AIVE analysis pipeline developed specifically to work with our i3n neuronal FIB-SEM dataset.
These macros comprise the code used in the analysis component of the FIB-SEM images for our pre-print at:
DOI: https://doi.org/10.1101/2024.09.09.611943 

The full protocol for working with this specific dataset and its 3D reconstruction can be found at: [TBA]

More information about AIVE and it's applications can be found in the previous publications:

"AI-directed voxel extraction and volume EM identify intrusions as sites of mitochondrial contact" (doi.org/10.1083/jcb.202411138)
"ATG4 family proteins drive phagophore growth independently of the LC3/GABARAP lipidation system" (doi.prg/10.1016/j.molcel.2021.03.001 )

The primary AIVE code can be found in the main AIVE repo at: 
https://github.com/BenPadman/AIVE

The primary AIVE plugin can be found in the main AIVE repo at:
https://github.com/BenPadman/AIVE/tree/FIJI-plugin

This process can be adapted to work with other datasets, although optimisation for each individual dataset is recommended.

## Introduction
This analysis pipeline was conducted on a 3D volumetric image stack of a cultured neuronal cell axon bouton. The image was aquired using a Helios 5 UX Cryo-FIBSEM. 
The images were taken with a voxel size of X= 3.0013nm, Y = 3.0013nm, Z=10nm.

## Fiji/ImageJ installation
The macros here require the installation of FIJI/ImageJ software and the Trainable WEKA Segemntation plugin.
- https://github.com/fiji
- https://github.com/fiji/Trainable_Segmentation

The associated research paper used the windows Fiji Version 1.53t.
The plugin's macro code also requires the following update sites to be added to your version of FIJI/imageJ:
- ImageScience
- ImageJ
- Fiji
- Java-8

## Plugin installation
Once you have your FIJI installation set up with the above dependencies the plugin can be installed.

Currently, the best way to install the plugin is to download the entire "AIVEI3N" folder from this repo, and paste it directly into the plugins folder in your FIJI/imageJ application. 
The plugins folder should then contain a sub folder named "AIVEI3N" which contains the current version of the .jar file, as well as the macro code in the "Macros" subfolder.

This open folder structure will allow you to make changes directly to the macros, if needed during optimisation, without needing to recompile the .jar.

The AIVEI3N plugin also contains a button to link back to the main AIVE control panel window. You will need to install this plugin for this to work properly.

An ImageJ update site will be established at some point to allow for easier installation.

## Hierachy of ImageJ macro structure

The macros used in the analysis of the FIB-SEM dataset are subset into three main parallel processes:
- Source image processing
  - Image pre-processing and 3D CLAHE filtering
- Membrane Prediction
  - Machine Learning using an adapted version of the trainable WEKA segmentation plugin
- Binary segmentation classification
  - Processing of binary maps of subclasses of membranes (optional)

A final fouth stage involves the AIVE merge calculation itself and post-processing steps
- Adapted AIVE merge
  - Image multiplication of segmentation with each of the source and the mebrane prediction. Noise reduction and uncertanty targeted filters as optimised for this dataset.
  Average of result of source and result membrane prediction. Contact overlap reduction to account for uncertainty introduced across immediately adjacent structures.

(Note: additional information on each process can be found in the individual READMEs)
