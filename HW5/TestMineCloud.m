R_i = load('R_m.mat');
R_i = R_i.R;
t_i = [3;0;0];

[X,Y,pointNumX,pointNumY] = TPGenerate(0.1,800,R_i,t_i);



X_i = X;
dimension = size(X,1);
pointNumX = size(X,2);
pointNumY = size(Y,2);
%X  = X + random('Normal',0,0.01,[dimension,pointNumX]);
figure(1);
%% Plot original point cloud
scatter3(X(2,:),X(1,:),X(3,:),'.','green');
%hold on,
%scatter3(Y(1,:),Y(2,:),Y(3,:),'.','red');
figure(2);
iter_plot = 2;  % plot point cloud each iter
%% padding data into 4 dimension
R_m = eye(3);
t_m = zeros(dimension,pointNumX);
iterNum = 18;
targetError = 0.001;
preError = 0;
for k = 1:iterNum
    if mod(k,iter_plot) ==0
        subplot(3,3,k/iter_plot);
        scatter3(X(2,:),X(1,:),X(3,:),'.','green');
        hold on,
        scatter3(Y(2,:),Y(1,:),Y(3,:),'.','red');
    end
    %% Step1 : Matching
    [dis,index] = findNeibor(X,Y);
    %% Step2 : Update (3 method)
    [R,t] = solveTransform(X,Y(:,index),3);
    X = R*X + repmat(t,[1,pointNumX]);
    currentError = sum(dis.^2);
    if abs(currentError-preError)<=targetError
        break
    end
    preError = currentError;
end

%%The total transformation
[R_m,t_m] = solveTransform(X_i,X,3);
%%The final transformation error
finalError = sum(sum(X-R_m*X_i-repmat(t_m,[1,pointNumX])).^2);