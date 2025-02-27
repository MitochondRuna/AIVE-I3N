/* AIVE bonus CoreB split macro
 *  This macro will split the result of the CoreB macro into classes and save the files as new stacks.
 *  It will only work on the .tif files in the directory, not any subdirectories.
 * The macro will automatically detect the number of classes based on the number of .tif files in the 
 * input folder. It will then save the class stacks with arbitray names to the output directory.
 * 
 * Macro prepared by R. Lindblom
 * Last updated: Feb 2025

 */

macro "Split CoreB Channels" {
	
	requires("1.53t");
	setBatchMode(true);

// Set directories
	dir = getDirectory("Choose the folder with the CoreB membrane prediction outputs");
    dirOut = getDirectory("OutputDirectory");

// Count files	
	count = 0;
	countFiles(dir);
	print("Number of files: "+count+"");

// Split 
	processFile(dir);
	
   	function countFiles(dir) {
    	list = getFileList(dir);
      	for (i=0; i<list.length; i++) {
          	if (endsWith(list[i],".tif")) {
              	count++; 
          	} else {
              	continue;
          	}
      	}
      }
  }
  end

 	function processFile(path) {

		File.openSequence(dir, "virtual");

	// Get parameters
		getDimensions(width, height, channels, slices, frames);
		print(width, height, channels, slices, frames);
		numSlices = slices;
		numClasses = numSlices/count;
		print("Number of channels detected: "+numClasses+"");	
		dirName = getTitle();
	
	// Run split
		run("Stack to Hyperstack...", "order=xyczt(default) channels="+numClasses+" slices="+count+" frames=1 display=Grayscale");
		run("Split Channels");
		
	// Save files	
		for (j = 1; j <= numClasses; j++) {

			selectWindow("C"+j+"-"+dirName+"");
			saveAs("tif", dirOut+"Class"+j+"");
			}

     	run("Close All");
 	}
}