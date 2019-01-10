%% step1: read image
get_img;
cali_data  = load('Calib_Results.mat');
KK = cali_data.KK;  %Camera Matrix
kc = cali_data.kc;  %Distored Vector
prompt_undis = 'Do you want to undistort your input? Y/N ([]=N)';
dist_str= input(prompt_undis,'s');
if isempty(dist_str)
    dist_str='N';
end

if dist_str=='Y'
%% step2: undistortion
undistortion;
end

%% step3: feature detection and matching
%num12 = match(img1,img2);
points1 = detectSURFFeatures(img1);
points2 = detectSURFFeatures(img2);
points3 = detectSURFFeatures(img3);
[f1,vpts1] = extractFeatures(img1,points1);
[f2,vpts2] = extractFeatures(img2,points2);
[f3,vpts3] = extractFeatures(img3,points3);
indexPairs12 = matchFeatures(f1,f2);
mPts12_1 = vpts1(indexPairs12(:,1));
mPts12_2 = vpts2(indexPairs12(:,2));
figure(2);
showMatchedFeatures(img1,img2,mPts12_1,mPts12_2);


%% step4: Estimate Fundamental Matrix
figure(3);
[F,inliersindex]  = estimateFundamentalMatrix(mPts12_1,mPts12_2,'Method','RANSAC','NumTrials',500,'DistanceThreshold',2e-3);
showMatchedFeatures(img1,img2,mPts12_1(inliersindex),mPts12_2(inliersindex));

%% step5: get R and t from Fundamental Matrix
E =  KK'*F*KK;



%% step6 triangulate
P1 = [eye(3);zeros(1,3)]*KK'; % Project Matrix of view1
P2 = findProject(E,KK',P1,mPts12_1(1),mPts12_2(1));
pts3D = triangulate(mPts12_1,mPts12_2,P1,P2);  % Reconstruct 3d points cloud
figure(4);
pcshow(pts3D);


%% step7: pose estimation
% match 1 and 3
indexPairs13 = matchFeatures(f1,f3);
mPts13_1 = vpts1(indexPairs13(:,1));
mPts13_3 = vpts3(indexPairs13(:,2));
% match 2 and 3
indexPairs23 = matchFeatures(f2,f3);
mPts23_2 = vpts2(indexPairs23(:,1));
mPts23_3 = vpts3(indexPairs23(:,2));






