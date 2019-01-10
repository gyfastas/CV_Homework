%% step2: undistortion
img1 = undistort(img1,[1080,1080],KK,kc);
img2 = undistort(img2,[1080,1080],KK,kc);
img3 = undistort(img3,[1080,1080],KK,kc);
prompt_save = 'Do you want to save the undistored img? Y/N ([]=N) ';
save_str = input(prompt_save,'s');
if isempty(save_str)
    save_str = 'N';
end

if save_str == 'Y'
    prompt_resolution  = 'Please input your save resolution(format: [H,W]) ([]=[640,640]) ';
    resolution  = input(prompt_resolution);
    if isempty(resolution)
        resolution = [640,640];
    end
    result1 = imresize(img1,resolution);
    result2 = imresize(img2,resolution);
    result3 = imresize(img3,resolution);
    imwrite(result1,'re1.tif');
    imwrite(result2,'re2.tif');
    imwrite(result3,'re3.tif');
end
