CellProfiler Pipeline: http://www.cellprofiler.org
Version:1
SVNRevision:11710

LoadImages:[module_num:1|svn_version:\'11587\'|variable_revision_number:11|show_window:False|notes:\x5B"Load the images by matching files in the folder against the unique text pattern for each stain\x3A \'Channel 1\' for protein, \'Channel 2\' for the nuclei image. The two images together comprise an image set."\x5D]
    File type to be loaded:individual images
    File selection method:Text-Exact match
    Number of images in each group?:3
    Type the text that the excluded images have in common:Do not use
    Analyze all subfolders within the selected folder?:None
    Input image file location:Default Input Folder\x7C.
    Check image sets for missing or duplicate files?:No
    Group images by metadata?:No
    Exclude certain files?:No
    Specify metadata fields to group by:
    Select subfolders to analyze:
    Image count:3
    Text that these images have in common (case-sensitive):_0001.tif
    Position of this image in each group:Channel 1
    Extract metadata from where?:File name
    Regular expression that finds metadata in the file name:(?P<Celltype>.*)-(?P<Time>.*)-(?P<Dose>.*)-(?P<Treatment>.*)-(?P<Replicate>.*)-_(.*)_(.*)
    Type the regular expression that finds metadata in the subfolder path:None
    Channel count:1
    Group the movie frames?:No
    Grouping method:Interleaved
    Number of channels per group:2
    Load the input as images or objects?:Images
    Name this loaded image:Phalloidin
    Name this loaded object:Nuclei
    Retain outlines of loaded objects?:No
    Name the outline image:NucleiOutlines
    Channel number:1
    Rescale intensities?:Yes
    Text that these images have in common (case-sensitive):_0002.tif
    Position of this image in each group:3
    Extract metadata from where?:File name
    Regular expression that finds metadata in the file name:(?P<Celltype>.*)-(?P<Time>.*)-(?P<Dose>.*)-(?P<Treatment>.*)-(?P<Replicate>.*)-_(.*)_(.*)
    Type the regular expression that finds metadata in the subfolder path:.*\x5B\\\\/\x5D(?P<Date>.*)\x5B\\\\/\x5D(?P<Run>.*)$
    Channel count:1
    Group the movie frames?:No
    Grouping method:Interleaved
    Number of channels per group:3
    Load the input as images or objects?:Images
    Name this loaded image:DAPI
    Name this loaded object:Nuclei
    Retain outlines of loaded objects?:No
    Name the outline image:LoadedImageOutlines
    Channel number:1
    Rescale intensities?:Yes
    Text that these images have in common (case-sensitive):_0000.tif
    Position of this image in each group:4
    Extract metadata from where?:File name
    Regular expression that finds metadata in the file name:(?P<Celltype>.*)-(?P<Time>.*)-(?P<Dose>.*)-(?P<Treatment>.*)-(?P<Replicate>.*)-_(.*)_(.*)
    Type the regular expression that finds metadata in the subfolder path:.*\x5B\\\\/\x5D(?P<Date>.*)\x5B\\\\/\x5D(?P<Run>.*)$
    Channel count:1
    Group the movie frames?:No
    Grouping method:Interleaved
    Number of channels per group:3
    Load the input as images or objects?:Images
    Name this loaded image:PBL
    Name this loaded object:Nuclei
    Retain outlines of loaded objects?:No
    Name the outline image:LoadedImageOutlines
    Channel number:1
    Rescale intensities?:Yes

IdentifyPrimaryObjects:[module_num:2|svn_version:\'10826\'|variable_revision_number:8|show_window:False|notes:\x5B\x5D]
    Select the input image:DAPI
    Name the primary objects to be identified:Nuclei
    Typical diameter of objects, in pixel units (Min,Max):10,45
    Discard objects outside the diameter range?:Yes
    Try to merge too small objects with nearby larger objects?:No
    Discard objects touching the border of the image?:Yes
    Select the thresholding method:Otsu Global
    Threshold correction factor:1
    Lower and upper bounds on threshold:0,1.0
    Approximate fraction of image covered by objects?:0.01
    Method to distinguish clumped objects:Intensity
    Method to draw dividing lines between clumped objects:Intensity
    Size of smoothing filter:15
    Suppress local maxima that are closer than this minimum allowed distance:7
    Speed up by using lower-resolution image to find local maxima?:Yes
    Name the outline image:NucleiOutlines
    Fill holes in identified objects?:Yes
    Automatically calculate size of smoothing filter?:No
    Automatically calculate minimum allowed distance between local maxima?:Yes
    Manual threshold:0.0
    Select binary image:None
    Retain outlines of the identified objects?:Yes
    Automatically calculate the threshold using the Otsu method?:Yes
    Enter Laplacian of Gaussian threshold:0.5
    Two-class or three-class thresholding?:Two classes
    Minimize the weighted variance or the entropy?:Weighted variance
    Assign pixels in the middle intensity class to the foreground or the background?:Foreground
    Automatically calculate the size of objects for the Laplacian of Gaussian filter?:Yes
    Enter LoG filter diameter:5
    Handling of objects if excessive number of objects identified:Continue
    Maximum number of objects:500
    Select the measurement to threshold with:None

IdentifyPrimaryObjects:[module_num:3|svn_version:\'10826\'|variable_revision_number:8|show_window:False|notes:\x5B\x5D]
    Select the input image:PBL
    Name the primary objects to be identified:PBL
    Typical diameter of objects, in pixel units (Min,Max):1,30
    Discard objects outside the diameter range?:Yes
    Try to merge too small objects with nearby larger objects?:Yes
    Discard objects touching the border of the image?:No
    Select the thresholding method:RobustBackground Global
    Threshold correction factor:3
    Lower and upper bounds on threshold:0,1.0
    Approximate fraction of image covered by objects?:0.01
    Method to distinguish clumped objects:Intensity
    Method to draw dividing lines between clumped objects:Intensity
    Size of smoothing filter:8
    Suppress local maxima that are closer than this minimum allowed distance:7
    Speed up by using lower-resolution image to find local maxima?:Yes
    Name the outline image:PBLOutlines
    Fill holes in identified objects?:Yes
    Automatically calculate size of smoothing filter?:No
    Automatically calculate minimum allowed distance between local maxima?:Yes
    Manual threshold:0.0
    Select binary image:None
    Retain outlines of the identified objects?:Yes
    Automatically calculate the threshold using the Otsu method?:Yes
    Enter Laplacian of Gaussian threshold:0.5
    Two-class or three-class thresholding?:Two classes
    Minimize the weighted variance or the entropy?:Weighted variance
    Assign pixels in the middle intensity class to the foreground or the background?:Foreground
    Automatically calculate the size of objects for the Laplacian of Gaussian filter?:Yes
    Enter LoG filter diameter:5
    Handling of objects if excessive number of objects identified:Continue
    Maximum number of objects:500
    Select the measurement to threshold with:None

IdentifySecondaryObjects:[module_num:4|svn_version:\'10826\'|variable_revision_number:7|show_window:False|notes:\x5B\x5D]
    Select the input objects:Nuclei
    Name the objects to be identified:Cells
    Select the method to identify the secondary objects:Propagation
    Select the input image:Phalloidin
    Select the thresholding method:Otsu Global
    Threshold correction factor:1
    Lower and upper bounds on threshold:0.000000,1.000000
    Approximate fraction of image covered by objects?:0.01
    Number of pixels by which to expand the primary objects:10
    Regularization factor:0.05
    Name the outline image:CellsOutlines
    Manual threshold:0.0
    Select binary image:None
    Retain outlines of the identified secondary objects?:Yes
    Two-class or three-class thresholding?:Two classes
    Minimize the weighted variance or the entropy?:Weighted variance
    Assign pixels in the middle intensity class to the foreground or the background?:Foreground
    Discard secondary objects that touch the edge of the image?:No
    Discard the associated primary objects?:No
    Name the new primary objects:FilteredNuclei
    Retain outlines of the new primary objects?:No
    Name the new primary object outlines:FilteredNucleiOutlines
    Select the measurement to threshold with:None
    Fill holes in identified objects?:Yes

RelateObjects:[module_num:5|svn_version:\'10300\'|variable_revision_number:2|show_window:False|notes:\x5B\x5D]
    Select the input child objects:PBL
    Select the input parent objects:Cells
    Calculate distances?:Both
    Calculate per-parent means for all child measurements?:No
    Calculate distances to other parents?:No
    Parent name:None

MeasureObjectIntensity:[module_num:6|svn_version:\'10816\'|variable_revision_number:3|show_window:False|notes:\x5B\x5D]
    Hidden:3
    Select an image to measure:DAPI
    Select an image to measure:Phalloidin
    Select an image to measure:PBL
    Select objects to measure:Cells
    Select objects to measure:Nuclei
    Select objects to measure:PBL

MeasureObjectSizeShape:[module_num:7|svn_version:\'1\'|variable_revision_number:1|show_window:False|notes:\x5B\x5D]
    Select objects to measure:Nuclei
    Select objects to measure:Cells
    Select objects to measure:PBL
    Calculate the Zernike features?:No

MaskImage:[module_num:8|svn_version:\'10428\'|variable_revision_number:3|show_window:False|notes:\x5B\x5D]
    Select the input image:Phalloidin
    Name the output image:MaskBackground
    Use objects or an image as a mask?:Objects
    Select object for mask:Cells
    Select image for mask:None
    Invert the mask?:Yes

MeasureImageIntensity:[module_num:9|svn_version:\'10816\'|variable_revision_number:2|show_window:False|notes:\x5B\x5D]
    Select the image to measure:MaskBackground
    Measure the intensity only from areas enclosed by objects?:No
    Select the input objects:None

GrayToColor:[module_num:10|svn_version:\'10341\'|variable_revision_number:2|show_window:False|notes:\x5B\x5D]
    Select a color scheme:RGB
    Select the input image to be colored red:Phalloidin
    Select the input image to be colored green:PBL
    Select the input image to be colored blue:DAPI
    Name the output image:ColorImage
    Relative weight for the red image:1
    Relative weight for the green image:1
    Relative weight for the blue image:1
    Select the input image to be colored cyan:Leave this black
    Select the input image to be colored magenta:Leave this black
    Select the input image to be colored yellow:Leave this black
    Select the input image that determines brightness:Leave this black
    Relative weight for the cyan image:1
    Relative weight for the magenta image:1
    Relative weight for the yellow image:1
    Relative weight for the brightness image:1
    Select the input image to add to the stacked image:None

OverlayOutlines:[module_num:11|svn_version:\'10672\'|variable_revision_number:2|show_window:False|notes:\x5B\x5D]
    Display outlines on a blank image?:No
    Select image on which to display outlines:ColorImage
    Name the output image:OrigOverlay
    Select outline display mode:Color
    Select method to determine brightness of outlines:Max of image
    Width of outlines:1
    Select outlines to display:NucleiOutlines
    Select outline color:Blue
    Select outlines to display:CellsOutlines
    Select outline color:Red
    Select outlines to display:PBLOutlines
    Select outline color:White

SaveImages:[module_num:12|svn_version:\'10822\'|variable_revision_number:7|show_window:False|notes:\x5B\x5D]
    Select the type of image to save:Image
    Select the image to save:OrigOverlay
    Select the objects to save:None
    Select the module display window to save:None
    Select method for constructing file names:From image filename
    Select image name for file prefix:DAPI
    Enter single file name:OrigBlue
    Do you want to add a suffix to the image file name?:No
    Text to append to the image name:
    Select file format to use:jpg
    Output file location:Default Output Folder sub-folder\x7CImages
    Image bit depth:8
    Overwrite existing files without warning?:Yes
    Select how often to save:Every cycle
    Rescale the images? :Yes
    Save as grayscale or color image?:Grayscale
    Select colormap:gray
    Store file and path information to the saved image?:No
    Create subfolders in the output folder?:No

ExportToSpreadsheet:[module_num:13|svn_version:\'10880\'|variable_revision_number:7|show_window:False|notes:\x5B\x5D]
    Select or enter the column delimiter:Comma (",")
    Prepend the output file name to the data file names?:Yes
    Add image metadata columns to your object data file?:Yes
    Limit output to a size that is allowed in Excel?:No
    Select the columns of measurements to export?:No
    Calculate the per-image mean values for object measurements?:No
    Calculate the per-image median values for object measurements?:No
    Calculate the per-image standard deviation values for object measurements?:No
    Output file location:Default Output Folder\x7CNone
    Create a GenePattern GCT file?:No
    Select source of sample row name:Metadata
    Select the image to use as the identifier:None
    Select the metadata to use as the identifier:None
    Export all measurements, using default file names?:Yes
    Press button to select measurements to export:
    Data to export:Do not use
    Combine these object measurements with those of the previous object?:No
    File name:DATA.csv
    Use the object name for the file name?:Yes
