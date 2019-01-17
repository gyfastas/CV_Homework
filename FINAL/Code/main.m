%% step1: read image
get_img;
cali_data  = load('Calib_params.mat');
cali_params = cali_data.cameraParams;
KK = cali_params.IntrinsicMatrix;  %Camera Matrix
kc = [cali_params.RadialDistortion,0,0,0];  %Distored Vector
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


%% step4: Estimate Essential Matrix
figure(3);
[E,inliersindex]  = estimateEssentialMatrix(mPts12_1,mPts12_2,cali_params);
% if estimateEssentialMatrix is not usable:
% [F,inliersindex] = estimateFundamentalMatrix(mPts12_1,mPts12_2);
% E = K'*F*K;
showMatchedFeatures(img1,img2,mPts12_1(inliersindex),mPts12_2(inliersindex));

%% step5: find relative pose
P1 = [eye(3);zeros(1,3)]*KK; % Project Matrix of view1
%P2 = findProject(E,KK,P1,mPts12_1(1),mPts12_2(1));
[RR,Rt] = relativeCameraPose(E,cali_params,mPts12_1(inliersindex),mPts12_2(inliersindex));
[rotationMatrix,translationVector] = cameraPoseToExtrinsics(RR,Rt);
P2 = cameraMatrix(cali_params,rotationMatrix,translationVector);
%% step6 triangulate
figure(4);
[pts3D,reprojectErr] = triangulate(mPts12_1(inliersindex),mPts12_2(inliersindex),P1,P2);  % Reconstruct 3d points cloud
average_reprojectErr = sum(reprojectErr)./size(reprojectErr,1);
fprintf('Constructing 3D point clouds...\n');
fprintf('The Average Reprojection Error is %f \n',average_reprojectErr); 
Loc1 = mPts12_1.Location';
Loc2 = mPts12_2.Location';
%pts3D_b = stereoReconsPts(P10,P20,Loc1,Loc2);
pcshow(pts3D);


%% step7: pose estimation
% match 1 and 3

indexPairs13 = matchFeatures(f1,f3);
% 对Features要使用M-Estimator去除outliers
mPts13_1 = vpts1(indexPairs13(:,1));
mPts13_3 = vpts3(indexPairs13(:,2));
[F13,inliersindex13]  = estimateFundamentalMatrix(mPts13_1,mPts13_3,'Method','RANSAC','DistanceThreshold',1e-2);
mPts13_1 = mPts13_1(inliersindex13);
mPts13_3 = mPts13_3(inliersindex13);
% match 2 and 3
indexPairs23 = matchFeatures(f2,f3);
mPts23_2 = vpts2(indexPairs23(:,1));
mPts23_3 = vpts3(indexPairs23(:,2));

%find corresponding points on 2D and 3D
index12_1 = indexPairs12(:,1); 
index12_1 = index12_1(find(inliersindex>0));
index12_2 = indexPairs12(:,1);
index13_1 = indexPairs13(:,1);
index13_1 = index13_1(find(inliersindex13>0));
index13_3 = indexPairs13(:,2);
index13_3 = index13_3(find(inliersindex13>0));
index3D = zeros(1,size(pts3D,1)); % 3D index of img3
index2D = zeros(1,size(index13_1,1));
for k = 1:size(index12_1,1)
    ind = find(index13_1==index12_1(k));
    if ind 
        index3D(k) = 1;
        index2D(ind) = 1;
    end
    
end
pts3_3D = pts3D(find(index3D==1),:);

pt3_2D = mPts13_3(find(index2D==1));
pt1_2D = mPts13_1(find(index2D==1));
%find index of pt2_2D:
index_in12 = zeros(1,size(pt1_2D,1));
for k = 1:size(pt1_2D,1)
    loc1 = mPts12_1.Location;
    loc2 = pt1_2D(k).Location;
    loc1 = loc1-repmat(loc2,[size(loc1,1),1]);
    loc1 = loc1(:,1).*loc1(:,2);
    index_in12(k) = find(loc1==0);
end
pt2_2D = mPts12_2(index_in12);
pts3_2D = mPts13_3(find(index2D==1));
pts3_2D  = pts3_2D.Location;
% using PnPRANSAC to get R and t
[RR3,Rt3] = estimateWorldCameraPose(pts3_2D,pts3_3D,cali_params);

%Visualization
 figure(5);
 pcshow(pts3_3D,'VerticalAxis','Y','VerticalAxisDir','down', ...
     'MarkerSize',30);
 hold on
 plotCamera('Size',5,'Orientation',RR3,'Location',...
     Rt3);
 
 %Reprojection error Calculation
 fprintf('Pose estimating...');
 [rotationMatrix3,translationVector3] = cameraPoseToExtrinsics(RR3,Rt3);
P3 = cameraMatrix(cali_params,rotationMatrix3,translationVector3);
reprojected_p3 = pts3_3D*P3(1:3,:)+P3(4,:);
reprojected_p3 = reprojected_p3./repmat(reprojected_p3(:,3),[1,3]);
reprojected_p3 = reprojected_p3(:,1:2);
diff_result = reprojected_p3 - pts3_2D;
diff_result = diff_result(:,1).*diff_result(:,1)+diff_result(:,2).*diff_result(:,2); %Distance
diff_result = sqrt(diff_result);
diff_sum = sum(diff_result);
pts_3_num =  size(pts3_3D,1);
diff_sum = diff_sum./pts_3_num;
fprintf('The Average reprojection error of pose estimation is: %f',diff_sum);



