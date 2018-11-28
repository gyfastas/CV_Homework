function [ OutImage ] = NLM( Input,BlockSize ,SearchSize,Method,Sigma)
%UNTITLED Summary of this function goes here
%Input: input image (RGB/Gray)
%BlockSize: 
%SearchSize: Search Region
%Method: the description function of Block 
%Sigma: variance of Gaussian Distance
if length(size(Input))==3
    Input = rgb2gray(Input);
end
[m,n] = size(Input);
%% Replicate the boundary of image
offset = floor(BlockSize/2); % Block Window offset
Soffset = floor(SearchSize/2); %Serach Window Offset
padInput = padarray(Input,[Soffset,Soffset],'symmetric');
[mm,nn] = size(padInput);
padOutput  = zeros(mm,nn);
FTInput = fft2(padInput);
Phase = angle(FTInput);
for x  = Soffset+1:m+Soffset
    for y = Soffset+1:n+Soffset
        Zx = 0;
        DisMax = 0;
        %% Method 1 use distance between face to indicates similarity
        if Method ==1 
        Block = Phase(x-offset:x+offset,y-offset:y+offset); %Block Phase
        
        for u = x-Soffset+offset+1:x+Soffset-offset
            for v = y-Soffset+offset+1:y+Soffset-offset
                RBlock = Phase(u-offset:u+offset,v-offset:v+offset);
                Distance = norm(Block-RBlock,2);
                Distance = exp(-Distance./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                padOutput(x,y) = padOutput(x,y)+Distance.*double(padInput(u,v));
            end
        end
        padOutput(x,y) = padOutput(x,y)./Zx;
        end
        %% Method2 use distance between (intensity-average instensity) to indicates similarity
        if Method ==2
        Block = padInput(x-offset:x+offset,y-offset:y+offset)-mean(mean(padInput)); %Block Intensity-mean
        Block = double(Block);
        for u = x-Soffset+offset+1:x+Soffset-offset
            for v = y-Soffset+offset+1:y+Soffset-offset
                RBlock = padInput(u-offset:u+offset,v-offset:v+offset)-mean(mean(padInput));
                RBlock = double(RBlock);
                Distance = norm(Block-RBlock,2);
                Distance = exp(-Distance./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                padOutput(x,y) = padOutput(x,y)+Distance.*double(padInput(u,v));
            end
        end
        padOutput(x,y) = padOutput(x,y)./Zx;
        end
    end
end
OutImage = padOutput(Soffset+1:m+Soffset,Soffset+1:n+Soffset);
OutImage = uint8(OutImage);

end

