function [R,t]= solveTransform(X,Y,method)
    %X: Source Point Cloud
    %Y: Destinition Point Cloud
    %method : 0->Gauss_Newton 1->DLT 2->QDLT

    dimension = size(X,1);
    pointNumX = size(X,2);
    pointNumY = size(Y,2);

    xcenter = mean(X,2);
    ycenter = mean(Y,2);

    NX = X - repmat(xcenter,[1,pointNumX]);
    NY = Y - repmat(ycenter,[1,pointNumY]);
    if method ==1
        [R,error] = Gauss_Newton(NX,NY,100);
        t = ycenter - R*xcenter;
    elseif method ==2
        [R,error] = DLT(NX,NY);
        t = ycenter - R*xcenter;
    elseif method ==3
        [Q,error] = QDLT(NX,NY);
        t = ycenter-q2r(Q)*xcenter;
    end
end