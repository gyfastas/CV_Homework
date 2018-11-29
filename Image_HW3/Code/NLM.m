function [ OutImage ] = NLM( Input,BlockSize ,SearchSize,Method,Sigma)
%Input: input image (RGB/Gray)
%BlockSize: 
%SearchSize: Search Region
%Method: the description function of Block
% Method = 1: phase
% Method = 2: intensity - mean(intensity)
%Sigma: variance of Gaussian Distance

%Ouput: output image (Gray)
if length(size(Input))==3
    Input = rgb2gray(Input);
end
[m,n] = size(Input);
%% Replicate the boundary of image
offset = floor(BlockSize/2); % Block Window offset
Soffset = floor(SearchSize/2); %Serach Window Offset
padInput = padarray(Input,[offset,offset],'symmetric');
[mm,nn] = size(padInput);
Output = double(zeros(m,n));
FTInput = fft2(padInput);
Phase = angle(FTInput);
Phase = Phase./max(max(Phase));
for x  = offset+1:m+offset
    for y = offset+1:n+offset
        Zx = 0;
        rmin = max(x-Soffset,offset+1);
        rmax = min(m+offset,x+Soffset);
        cmin = max(y-Soffset-offset,offset+1);
        cmax = min(y+Soffset+offset,n+offset);
        %% Method 1 use distance between face to indicates similarity
        if Method ==1 
        Block = fft2(padInput(x-offset:x+offset,y-offset:y+offset));
        Block = angle(Block);
        
        for u = rmin:rmax
            for v = cmin:cmax
                RBlock = fft2(padInput(u-offset:u+offset,v-offset:v+offset));
                RBlock = angle(RBlock);
                Distance = norm(Block-RBlock,2);
                Distance = exp(-Distance./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                Output(x-offset,y-offset) = Output(x-offset,y-offset)+Distance.*double(padInput(u,v));
            end
        end
        Output(x-offset,y-offset) = Output(x-offset,y-offset)./Zx;
        end
        %% Method2 use distance between intensity to indicates similarity
        if Method ==2
        Block = padInput(x-offset:x+offset,y-offset:y+offset); %Block Intensity
        Block = double(Block);
        for u = rmin:rmax
            for v = cmin:cmax
                RBlock = padInput(u-offset:u+offset,v-offset:v+offset);
                RBlock = double(RBlock);
                Distance = norm(Block-RBlock,2);
                Distance = exp(-Distance./(Sigma*Sigma*2));
                Zx = Zx+Distance;
                Output(x-offset,y-offset) = Output(x-offset,y-offset)+Distance.*double(padInput(u,v));
            end
        end
        Output(x-offset,y-offset) = Output(x-offset,y-offset)./Zx;
        end
    end
end
OutImage = uint8(Output);

end

