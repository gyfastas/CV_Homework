%% read image after undistortion
prompt = 'Please enter the path of your input image ([] = input_img)';
path  = input(prompt,'s');
if isempty(path)
    path = 'input_img';
end
prompt0 = 'Please input the basename of your image: ';
basename = input(prompt0,'s');
prompt1 = 'Please input the format fo your image ([]=j=jpg, t=tif, p=png): ';
format = input(prompt1,'s');
if isempty(format)
    format = 'jpg';
elseif format=='j'
    format = 'jpg';
elseif format=='t'
    format = 'tif';
elseif format=='p'
    formt = 'png';
end
iname1 = [path,'/', basename, '01.', format];
iname2 = [path,'/', basename, '02.', format];
iname3 = [path,'/', basename, '03.', format];

img1 = imread(iname1);
img2 = imread(iname2);
img3 = imread(iname3);
if length(size(img1))>2
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img3 = rgb2gray(img3);
end




