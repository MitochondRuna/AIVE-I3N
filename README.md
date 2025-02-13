# AIVE-I3N
## Overview
The following macros were developed to run in FIJI ImageJ software version 1.53t. 

The macros can be opened directly in ImageJ and run, or added to the macros folder in your local copy of ImageJ.

The code here represents the adapted version of the AIVE analysis pipeline developed specifically to work with our i3n neuronal FIB-SEM dataset.
These macros comprise the code used in the analysis component of the FIB-SEM images for our pre-print at:
DOI: https://doi.org/10.1101/2024.09.09.611943 

The full protocol for working with this specific dataset and its 3D reconstruction can be found at: ___

The original publications for the AIVE pipeline development can be found: ___

The primary AIVE code can be found in the main AIVE repo at: 
https://github.com/BenPadman/AIVE

This process can be adapted to work with other datasets, although optimisation for each individual dataset is recommended.

## Introduction
This analysis pipeline was conducted on a 3D volumetric image stack of a cultured neuronal cell axon bouton. The image was aquired using a ___ 
The images were taken with a voxel size of X= 3.0013nm, Y = 3.0013nm, Z=10nm.

## Fiji/ImageJ installation
The macros here require the installation of FIJI/ImageJ software and the Trainable WEKA Segemntation plugin.
- https://github.com/fiji
- https://github.com/fiji/Trainable_Segmentation

The associated research paper used the windows Fiji Version 1.53t.
The macro code here requires the following update sites to be added:
- ImageScience
- ImageJ
- Fiji
- Java-8

## Hierachy of ImageJ macro structure

The macros used in the analysis of the FIB-SEM dataset are subset into three main parallel processes:
- Source processing
  - Image pre-processing and 3D CLAHE filtering
- Membrane Prediction
  - Machine Learning using an adapted version of the trainable WEKA segmentation plugin
- Binary segmentation classification
  - Processing of binary maps of subclasses of membranes (optional)

A final fouth stage involves the AIVE merge calculation itself and post-processing steps
- Adapted AIVE merge
  - Image multiplication of segmentation with each of the source and the mebrane prediction. Noise reduction and uncertanty targeted filters as optimised for this dataset.
  Average of result of source and result membrane prediction. Contact overlap reduction to account for uncertainty introduced across immediately adjacent structures.

(Note: additional information on each process can be found in their individual READMEs)
