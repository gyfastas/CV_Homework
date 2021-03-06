%% load data
data = load('./data/icp_xy.mat');
X = data.x;
Y = data.y;
X_i = X;
dimension = size(X,1);
pointNumX = size(X,2);
pointNumY = size(Y,2);
X  = X + random('Normal',0,0.01,[dimension,pointNumX]);
figure(1);
%% Plot original point cloud
scatter3(X(1,:),X(2,:),X(3,:),'.','green');
hold on,
scatter3(Y(1,:),Y(2,:),Y(3,:),'.','red');
figure(2);
iter_plot = 1;  % plot point cloud each iter
%% padding data into 4 dimension
R_m = eye(3);
t_m = zeros(dimension,pointNumX);
iterNum = 9;
targetError = 0.001;
preError = 0;
for k = 1:iterNum
    if mod(k,iter_plot) ==0
        subplot(3,3,k/iter_plot);
        scatter3(X(1,:),X(2,:),X(3,:),'.','green');
        hold on,
        scatter3(Y(1,:),Y(2,:),Y(3,:),'.','red');
    end
    %% Step1 : Matching
    [dis,index] = findNeibor(X,Y);
    %% Step2 : Update (3 method)
    [R,t] = solveTransform(X,Y(:,index),2);
    X = R*X + repmat(t,[1,pointNumX]);
    currentError = sum(dis.^2);
    if abs(currentError-preError)<=targetError
        break
    end
    preError = currentError;
end

%%The total transformation
[R_m,t_m] = solveTransform(X_i,X,2);
%%The final transformation error
finalError = sum(sum(X-R_m*X_i-repmat(t_m,[1,pointNumX])).^2);

%% Plot





