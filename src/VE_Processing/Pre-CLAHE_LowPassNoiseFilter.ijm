macro "LPNF [F9]"{

   requires("1.53t");
   setOption("JFileChooser", true);
   
// set image and output directory
   OriginalImage = File.openDialog("Select the FIB-SEM working image");
   outdir = getDirectory("Output Directory");

// open file
   open(OriginalImage);
   //selectImage(OriginalImage);
   ImageName = File.getNameWithoutExtension(OriginalImage);

// process file
   run("Duplicate...", "title=Gaussian.tif duplicate");
   run("Gaussian Blur 3D...", "x=1 y=1 z=0.33");

   imageCalculator("Average create stack", ImageName+".tif","Gaussian.tif");
   selectImage("Result of "+ImageName+".tif");

//save and close
        saveAs("tif", outdir+ImageName+"AG.tif");
        run("Close All");

}
