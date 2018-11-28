%% Test On Yale Dataset
N = 50;			%Face size
M = 5;			%Eigen Face number
TM = 5;        %Training set number
%% read image
face_mat = zeros(N*N,TM);
for k = 1:TM
    if k<10
        temp_face = imread(['../Resources/tests/','subject0',char(k+'0'),'.normal.pgm']);
    else
        temp_face = imread(['../Resources/tests/','subject1',char(k-10+'0'),'.normal.pgm']);
    end 
    temp_face = imresize(temp_face,[N,N]);
    face_mat(:,k) = double(reshape(temp_face',[N*N,1]));
end

%% read test img
face_test = imread('../Resources/tests/subject01.happy.pgm' );
face_test = imresize(face_test,[N,N]);
face_test = double(face_test);
face_test_vec = reshape(face_test',[N*N,1]);

%% average face and differ
avg_face = 1./TM*sum(face_mat,2);
diff_mat = face_mat - repmat(avg_face,1,TM);

avg_face_show = reshape(avg_face,N,N)';
figure(1),imshow(uint8(avg_face_show));

%% Covariance Matrix
cov_mat = diff_mat*diff_mat';
replace_mat = diff_mat'*diff_mat;  %%replace cov mat
[eigvec,eigmat]  = eig(replace_mat); %% eigen vector of replace cov mat

%% PCA and Build Eigen Face
eigvec_L = diff_mat*eigvec;
eigenface = [];
for k = 1:TM
    eigenface{k} = reshape(eigvec_L(:,k),[N,N])';
end

eigvalue = diag(eigmat); 
[xc,xic] = sort(eigvalue,'descend');

mainface = [];
figure(2);
for k = 1:M
    mainface{k} = eigenface{xic(k)};
    subplot(3,2,k);
    imshow(uint8(mainface{k}));
end 


%% Project new face into face space
face_test_vec = reshape(face_test',[N*N,1]); %x
face_test_eigen = face_space'*(face_test_vec-avg_face); %p
face_x = reshape(face_test,[N*N,1]);
%% calculate distance in subspace and reconstructed face
dis = zeros(1,M);
reconstructed_face = face_space*face_test_eigen+avg_face;
Construct_dis = norm((face_test_vec-reconstructed_face),2); 
for tt = 1:M
 dis(1,tt) = norm(face_test_eigen-project_face(:,tt),2);
end

thres = 0.5*max(dis);
dis = dis./thres;
Cons_dis = Construct_dis./thres;


