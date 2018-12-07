function [dis,index] = findClosest(X,Y)
    %Matching point (find nearest point in Y for X)
    %Input:
    %X: Source Point Cloud (N1*3)
    %Y: Distnition Point Cloud (N2*3)
    
    %Output:
    %dis: distance of neighbor
    %index: index of x to y

    [dimension,pointNumY] = size(Y);
    pointNumX = size(X,2);
    index = zeros(1,pointNumX);
    dis = zeros(1,pointNumX);
    for m = 1:pointNumX
        diffMat = repmat(X(:,m),[1,pointNumY]) - Y;
        disMat = sqrt(sum(diffMat.^2));
        [B,IX] = sort(disMat,'ascend');
        dis(m) = disMat(IX(1));
        index(m) = IX(1);
    end


end