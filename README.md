# AIVE-I3N
## Overview
The following macros were developed to run in FIJI ImageJ software version 1.53t. 

The macros can be opened directly in ImageJ and run, or added to the macros folder in your local copy of ImageJ.

These macros comprise the complete code set used in the analysis component of the FIB-SEM images published in ___
The full protocol for working with this specific dataset and its 3D reconstruction can be found at: ___
This process can be adapted to work with other datasets, although optimisation for each individual dataset is recommended.

## Introduction
This analysis pipeline was conducted on a 3D volumtic image stack of a cultured neuronal cell axon bouton. The image was aquired using a ___ 


## Hierachy of ImageJ macro structure

The macros used in the analysis of the FIB-SEM dataset are subset into three main parallel processes:
- Source processing
  Image pre-processing and 3D CLAHE filtering
- Membrane Prediction
  Machine Learning using an adapted version of the trainable WEKA segmentation plugin
- Binary segmentation classification
  Processing of binary maps of subclasses of membranes (optional)

A final fouth stage involves the AIVE merge calculation itself and post-processing steps
- AIVE merge

(Note: additional information on each process can be found in their individual READMEs)
