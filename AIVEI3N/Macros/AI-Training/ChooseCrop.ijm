/* This macro allows you to preset a 3D bounding box to crop an image
 * It will then allow you to set a directory to save the cropped image
 * It should be compatible with earlier versions of Fiji but was only tested in v1.53
 *
 * Last updated: Aug 2024 by R. Lindblom
 */

macro "Choose_3DImageCropper [F9]"{

   requires("1.53s");
   setOption("JFileChooser", true);

if (nImages == 0) {
	run("Open...");
}

getDimensions(width, height, channels, slices, frames);
imageTitle = getTitle();

Dialog.create("3D Image Cropper");
Dialog.addMessage("You must set the box start point using the coordinates of the upper left corner pixel.");
Dialog.addMessage("Set location of bounding box corner:");
Dialog.addNumber("X pixel start location", 0);
Dialog.addNumber("Y pixel start location", 0);
Dialog.addNumber("Z slice start location", 0);
Dialog.addMessage("Set size of bounding box:");
Dialog.addNumber("Length of Box in X", width);
Dialog.addNumber("Length of Box in Y", height);
Dialog.addNumber("Number of slices in Z", slices);
Dialog.addCheckbox("Set save directory?", true);
Dialog.addCheckbox("Preview bounding box?", true);
Dialog.show();


Start_X = Dialog.getNumber();
Start_Y = Dialog.getNumber();
Start_Z = Dialog.getNumber();
Length_X = Dialog.getNumber();
Length_Y = Dialog.getNumber();
Length_Z = Dialog.getNumber();
GetDir = Dialog.getCheckbox();
ConfirmBox = Dialog.getCheckbox();

if (GetDir == true)
OutDir = getDirectory("Directory to save outputs");

if (GetDir == false)
print("Cropped image will not be saved automatically");

if (slices >= 1) {
End_Z = Start_Z+Length_Z;
run("Duplicate...", "duplicate range="+Start_Z+"-"+End_Z+"");
}

print("Image cropped to "+Length_X+" by "+Length_Y+" pixels from point: X="+Start_X+" Y= "+Start_Y+"");
makeRectangle(Start_X, Start_Y, Length_X, Length_Y);

if (ConfirmBox == true) {
Dialog.create("Preview location");
Dialog.addMessage("Confirm location of box to crop?");
Dialog.show();
}

run("Crop");
rename(imageTitle+"_cropped.tif");
CroppedImageName = getTitle();

if (GetDir == true)
saveAs("TIFF", OutDir+CroppedImageName+".tif");


}
