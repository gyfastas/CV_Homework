function [ OutImage ] = NLM( Input,BlockSize ,SearchSize,Method,Sigma,Stride)
%UNTITLED Summary of this function goes here
%Input: input image (RGB/Gray)
%BlockSize: 
%SearchSize: Search Region
%Method: the description function of Block 
%Sigma: variance of Gaussian Distance
%Stride: Search Stride 

[m,n] = size(Input);
%% Replicate the boundary of image
offset = floor(BlockSize/2); % Block Window offset
Soffset = floor(SearchSize/2); %Serach Window Offset
Out = zeros(m,n);
FTInput = fft2(Input);
Phase = angle(FTInput);
for x  = offset+1:m-offset
    for y = offset+1:n-offset
        Zx = 0;
        rmin = max(x-Soffset-offset,offset+1);
        rmax = min(m-offset,x+Soffset+offset);
        cmin = max(y-Soffset-offset,offset+1);
        cmax = min(y+Soffset+offset,n-offset);
        if Method ==1 
        Block = Phase(x-offset:x+offset,y-offset:y+offset); %Block Phase
        
        for u = rmin:Stride:rmax
            for v = cmin:Stride:cmax
                RBlock = Phase(u-offset:u+offset,v-offset:v+offset);
                Distance = norm(Block-RBlock,2);
                Distance = exp((-Distance)./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                Out(x,y) = Out(x,y)+Distance.*double(Input(u,v));
            end
        end
        Out(x,y) = Out(x,y)./Zx;
        end
        
        if Method ==2
        Block = Input(x-offset:x+offset,y-offset:y+offset) - mean(mean(Input(x-offset:x+offset,y-offset:y+offset))); %Block Intensity-mean
        Block = double(Block);
        for u = rmin:Stride:rmax
            for v = cmin:Stride:cmax
                RBlock = Input(u-offset:u+offset,v-offset:v+offset)-mean(mean(Input(u-offset:u+offset,v-offset:v+offset)));
                RBlock = double(RBlock);
                Distance = norm(Block-RBlock,2);
                Distance = exp(-Distance./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                Out(x,y) = Out(x,y)+Distance.*double(Input(u,v));
            end
        end
        Out(x,y) = Out(x,y)./Zx;
        end
    end
end
Out(Out==0) = Input(Out==0);
OutImage = uint8(Out);

end

