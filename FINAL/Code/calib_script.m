% Auto-generated by cameraCalibrator app on 11-Jan-2019
%-------------------------------------------------------


% Define images to process
imageFileNames = {'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image1.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image2.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image2.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image3.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image3.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image4.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image4.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image5.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image5.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image6.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image6.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image7.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image7.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image9.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image9.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image10.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image10.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image12.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image12.tif',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image14.jpg',...
    'D:\GIT\CV_Homework\FINAL\Code\TOOLBOX_calib\Image14.tif',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
