% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1192.671616569884200 ; 1192.623741001372100 ];

%-- Principal point:
cc = [ 536.681107921865760 ; 524.146950484975040 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.135619404130185 ; -0.465078776609316 ; 0.000323440584850 ; -0.001318858696906 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 2.366674743146809 ; 2.370397965646617 ];

%-- Principal point uncertainty:
cc_error = [ 2.640754160600922 ; 2.799319929908286 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.009207457963233 ; 0.039080590543829 ; 0.000974528594926 ; 0.000894082836655 ; 0.000000000000000 ];

%-- Image size:
nx = 1080;
ny = 1080;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 14;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.222719e+00 ; 2.206424e+00 ; -3.559402e-02 ];
Tc_1  = [ -2.452358e+02 ; -1.993332e+02 ; 7.624726e+02 ];
omc_error_1 = [ 2.223482e-03 ; 2.078857e-03 ; 4.559014e-03 ];
Tc_error_1  = [ 1.707640e+00 ; 1.827677e+00 ; 1.726321e+00 ];

%-- Image #2:
omc_2 = [ -1.807730e+00 ; -1.923367e+00 ; 6.378713e-01 ];
Tc_2  = [ -2.553917e+02 ; -2.238603e+02 ; 1.063887e+03 ];
omc_error_2 = [ 2.293765e-03 ; 1.774305e-03 ; 3.292670e-03 ];
Tc_error_2  = [ 2.348043e+00 ; 2.515662e+00 ; 1.769146e+00 ];

%-- Image #3:
omc_3 = [ 1.945781e+00 ; 1.736102e+00 ; 4.770465e-01 ];
Tc_3  = [ -1.680120e+02 ; -2.007524e+02 ; 7.779821e+02 ];
omc_error_3 = [ 2.313863e-03 ; 1.580751e-03 ; 3.430445e-03 ];
Tc_error_3  = [ 1.758793e+00 ; 1.835856e+00 ; 1.719300e+00 ];

%-- Image #4:
omc_4 = [ -2.059717e+00 ; -2.020259e+00 ; -3.626272e-01 ];
Tc_4  = [ -2.490753e+02 ; -2.120308e+02 ; 8.639959e+02 ];
omc_error_4 = [ 2.016358e-03 ; 2.277974e-03 ; 4.169259e-03 ];
Tc_error_4  = [ 1.951133e+00 ; 2.093128e+00 ; 1.999442e+00 ];

%-- Image #5:
omc_5 = [ 2.090250e+00 ; 2.055946e+00 ; -2.838703e-01 ];
Tc_5  = [ -2.339622e+02 ; -2.329481e+02 ; 9.555350e+02 ];
omc_error_5 = [ 2.135546e-03 ; 2.256078e-03 ; 4.197729e-03 ];
Tc_error_5  = [ 2.123555e+00 ; 2.245659e+00 ; 1.896105e+00 ];

%-- Image #6:
omc_6 = [ -2.117860e+00 ; -1.835939e+00 ; 8.490881e-01 ];
Tc_6  = [ -2.040964e+02 ; -1.947941e+02 ; 1.242765e+03 ];
omc_error_6 = [ 2.634674e-03 ; 1.648447e-03 ; 3.778358e-03 ];
Tc_error_6  = [ 2.758599e+00 ; 2.903930e+00 ; 1.974440e+00 ];

%-- Image #7:
omc_7 = [ 1.646512e+00 ; 1.857719e+00 ; 1.810500e-01 ];
Tc_7  = [ -1.003992e+02 ; -2.510922e+02 ; 9.179482e+02 ];
omc_error_7 = [ 2.157638e-03 ; 1.883662e-03 ; 3.258983e-03 ];
Tc_error_7  = [ 2.042180e+00 ; 2.150234e+00 ; 1.815066e+00 ];

%-- Image #8:
omc_8 = [ -1.808445e+00 ; -2.123736e+00 ; -1.294221e+00 ];
Tc_8  = [ -1.285476e+02 ; -6.370834e+01 ; 6.613874e+02 ];
omc_error_8 = [ 1.503826e-03 ; 2.860418e-03 ; 3.488784e-03 ];
Tc_error_8  = [ 1.472639e+00 ; 1.585462e+00 ; 1.771354e+00 ];

%-- Image #9:
omc_9 = [ -1.863149e+00 ; -1.823152e+00 ; -2.480100e-01 ];
Tc_9  = [ -2.532005e+02 ; -1.784802e+02 ; 1.002705e+03 ];
omc_error_9 = [ 2.002986e-03 ; 2.203209e-03 ; 3.579253e-03 ];
Tc_error_9  = [ 2.224360e+00 ; 2.392468e+00 ; 2.138744e+00 ];

%-- Image #10:
omc_10 = [ 2.018773e+00 ; 2.035030e+00 ; 1.277754e+00 ];
Tc_10  = [ -1.235775e+02 ; -1.039235e+02 ; 6.498610e+02 ];
omc_error_10 = [ 2.738038e-03 ; 1.395732e-03 ; 3.660805e-03 ];
Tc_error_10  = [ 1.464108e+00 ; 1.554305e+00 ; 1.724594e+00 ];

%-- Image #11:
omc_11 = [ -1.982191e+00 ; -2.037829e+00 ; -9.883056e-01 ];
Tc_11  = [ -1.686598e+02 ; -1.184546e+02 ; 7.063136e+02 ];
omc_error_11 = [ 1.516854e-03 ; 2.603675e-03 ; 3.621428e-03 ];
Tc_error_11  = [ 1.587695e+00 ; 1.695517e+00 ; 1.778452e+00 ];

%-- Image #12:
omc_12 = [ 2.050736e+00 ; 1.986193e+00 ; 2.237095e-01 ];
Tc_12  = [ -1.896963e+02 ; -2.211156e+02 ; 8.119905e+02 ];
omc_error_12 = [ 2.280441e-03 ; 1.831567e-03 ; 4.047638e-03 ];
Tc_error_12  = [ 1.833628e+00 ; 1.924934e+00 ; 1.797805e+00 ];

%-- Image #13:
omc_13 = [ 2.297100e+00 ; 2.028594e+00 ; 6.081557e-01 ];
Tc_13  = [ -1.808156e+02 ; -1.774209e+02 ; 8.284679e+02 ];
omc_error_13 = [ 2.583528e-03 ; 1.624777e-03 ; 4.415501e-03 ];
Tc_error_13  = [ 1.878715e+00 ; 1.968104e+00 ; 1.989929e+00 ];

%-- Image #14:
omc_14 = [ -1.942657e+00 ; -1.841840e+00 ; -6.656086e-01 ];
Tc_14  = [ -2.277898e+02 ; -1.993159e+02 ; 8.910415e+02 ];
omc_error_14 = [ 1.851837e-03 ; 2.324200e-03 ; 3.636434e-03 ];
Tc_error_14  = [ 2.010085e+00 ; 2.155009e+00 ; 2.090386e+00 ];

