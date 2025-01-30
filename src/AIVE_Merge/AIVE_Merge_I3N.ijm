/* "AIVE_Merge_I3N"
    This macro contains the processing steps applied to the AIVE image analysis
    of the I3N FIB-SEM dataset in this repository.
    The macro requires 4 inputs.
    1. AIVE membrane prediction result (32-bit .tif)
    2. CLAHE processed FIB-SEM source (8-bit .tif)
    3. Combined binary ROI of segmentation results (8-bit .tif)
    4. Folder of individual binary ROIs (8-bit .tifs)

    The macro applies image multiplication by ROI for both images 1 and 2.
    This is then followed by an average merge of the two image results.
    The result is run through a contact point proximity subtraction using 4.
    before a final post-blur of 3nm.
*/
// Updated by R. Lindblom 21-08-24

macro "AIVE_Merge_I3N [F9]"{

   requires("1.53t");
   setOption("JFileChooser", true);
   CLAHEFilePath = File.openDialog("Select CLAHE Inverse image");
   MEMBFilePath2 = File.openDialog("Select 32-bit Membrane prediction image");
   COMBROIFilePath3 = File.openDialog("Select the combined binary segmentation mask");
   dir = getDirectory("Choose the folder with binary MIB masks (segmented ROI tiff stacks)");
   outdir = getDirectory("OutputDirectory");

   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   //print(count+" files processed");

   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }

  function processFile(path) {

//Open files and set names
     open(path);
     ROISEG = File.getName(path);

     open(CLAHEFilePath);
     open(MEMBFilePath2);
     open(COMBROIFilePath3);

     SOURCE = File.getName(CLAHEFilePath);
     MEMB = File.getName(MEMBFilePath2);
     COMBROI = File.getName(COMBROIFilePath3);

// preprocess and blur combined MIB masks
	   imageCalculator("Subtract create stack", COMBROI, ROISEG);
		 selectWindow("Result of "+COMBROI);
		      run("Erode", "stack");
		      run("Gaussian Blur 3D...", "x=3 y=3 z=1");
		 setMinAndMax(0, 512);
          call("ij.ImagePlus.setDefault16bitRange", 8);
          run("Apply LUT", "stack");

// GA blur binary mask
	   selectWindow(ROISEG);
	        run("Duplicate...", "duplicate");
	        rename("blurred.tif");
	        run("Gaussian Blur 3D...", "x=3 y=3 z=1");
	   imageCalculator("Add create stack", ROISEG, "blurred.tif");
	   selectWindow("Result of "+ROISEG);
	        run("Gaussian Blur 3D...", "x=3 y=3 z=1");

// process source file
     selectWindow(SOURCE);
          run("8-bit");

     selectWindow("Result of "+ROISEG);

     imageCalculator("Multiply create stack 32-bit", SOURCE, "Result of "+ROISEG);
          setMinAndMax(0, 65025);
          run("8-bit");

// process WEKA membrane prediction file
     selectWindow(MEMB);
          run("8-bit");
     imageCalculator("Multiply create stack 32-bit", MEMB, "Result of "+ROISEG);
          setMinAndMax(0, 65025);
          run("8-bit");
          run("Gaussian Blur 3D...", "x=3 y=3 z=1");

// Average signal of both outputs
     imageCalculator("Average create stack", "Result of "+MEMB, "Result of "+SOURCE);
     selectWindow("Result of Result of "+MEMB);

// Minimise contact overlap from blur
     imageCalculator("Subtract create stack", "Result of Result of "+MEMB, "Result of "+COMBROI);

// final post blur smoothing of 3nm
     run("Gaussian Blur 3D...", "x=1 y=1 z=.33");

//save and close
     saveAs("tif", outdir+list[i]);

     run("Close All");

      }
   }

}
