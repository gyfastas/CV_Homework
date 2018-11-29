%% Test On Yale Dataset
N = 80;			%Face size
M = 10;			%Eigen Face number
TM = 12;        %Training set number
%% read image
face_mat = zeros(N*N,TM);
for k = 1:10
    if k<10
        temp_face = imread(['../Resources/tests/','subject0',char(k+'0'),'.normal.pgm']);
    else
        temp_face = imread(['../Resources/tests/','subject1',char(k-10+'0'),'.normal.pgm']);
    end 
    temp_face = imresize(temp_face,[N,N]);
    face_mat(:,k) = double(reshape(temp_face,[N*N,1]));
end
%% extra face
temp_face = imread('../Resources/tests/subject01.sleepy.pgm');
temp_face = imresize(temp_face,[N,N]);
face_mat(:,11) = double(reshape(temp_face,[N*N,1]));
temp_face = imread('../Resources/tests/subject02.surprised.pgm');
temp_face = imresize(temp_face,[N,N]);
face_mat(:,12) = double(reshape(temp_face,[N*N,1]));

%% read test img
face_test = imread('../Resources/tests/subject15.sad.pgm' );
face_test = imresize(face_test,[N,N]);
face_test = double(face_test);
face_test_vec = reshape(face_test,[N*N,1]);

%% average face and differ
avg_face = 1./TM*sum(face_mat,2);
diff_mat = face_mat - repmat(avg_face,1,TM);

avg_face_show = reshape(avg_face,N,N)';
figure(1),imshow(uint8(avg_face_show'));

%% Covariance Matrix
cov_mat = diff_mat*diff_mat';
replace_mat = diff_mat'*diff_mat;  %%replace cov mat
%[eigvec,eigmat]  = eig(replace_mat); %% eigen vector of replace cov mat

%% PCA 
[eigvec,wcols] = MYPCA(diff_mat,M);

%% Project new face into face space
test_weight_cols = eigvec\(face_test_vec-avg_face); % get weight cols of testimg

%% calculate distance in subspace and reconstructed face
dis = zeros(1,TM);
%reconstructed_face = face_space*face_test_eigen+avg_face;
%Construct_dis = norm((face_test_vec-reconstructed_face),2); 
for tt = 1:TM
 dis(1,tt) = norm(test_weight_cols-wcols(:,tt),2);
end
thres = 0.5*max(dis);

dis = dis./thres;

%% reconstructed face vector
reconstructed_vec = eigvec*test_weight_cols + avg_face;
reconstructed_face = uint8(reshape(reconstructed_vec,[N,N]));
figure(2);
subplot(121);
imshow(uint8(face_test));
subplot(122);
imshow(reconstructed_face);
dis_ro = norm(reconstructed_vec-face_test_vec,2);
dis_ro = dis_ro./thres;
%Cons_dis = Construct_dis./thres;

%% conclusion
if dis_ro<1
    fprintf('The test image is a face\n');
    fprintf('The face is closest to %d, the distance is %d',find(dis==min(dis)),min(dis));
else
    fprintf('The test image is not a face');
end
