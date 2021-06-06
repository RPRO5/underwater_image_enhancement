clc;
clear all;
close all;

trainData = imageSet('./u45 dataset','recursive');
patchSize = 15;       %the patch size is set to be 15 x 15
padSize =  floor((patchSize-1)/2);
newSize = 500;      %Size of the image
intialRegions = 5;    %number of regions for segmentation
OutputPath = './u45/';   % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;


%    %Pre-Processing
    image = imresize(img, [newSize,newSize]);
    image=double(image);
    image=image./255;

tic; % 计时开始

win_size = 15;
W = 0.95;
t0 = 0.1;
l = 10^-4;


 
%Udark = get_underwater_dark_channel(image, win_size);
Udark = get_dark_channel(image, win_size);
Atom  = get_atomsphere(image, Udark); 

%t = 1 - W * get_underwater_dark_channel(image ./ Atom, win_size);
t = 1 - W * get_dark_channel(image ./ Atom, win_size);
trans_est = softmatting(image, t, l);
%figure('name', 't'); imshow(trans_est);

max_trans_est = repmat(max(trans_est, 0.1), [1, 1, 3]);

% 求解清晰图像
% J = (I-A)/max(t,t(0)) + A

result = ( (image - Atom)./max_trans_est ) + Atom;

toc; % 计时结束

%figure('name', 'forest_recover.jpg'); imshow(result);
%Save Image
    savepath = strcat(OutputPath,imgname, '.png');
    imwrite(result,savepath);
    
    
end