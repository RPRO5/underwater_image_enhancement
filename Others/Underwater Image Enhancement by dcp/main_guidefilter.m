clc;
clear all;
close all;

trainData = imageSet('./Dataset','recursive');
patchSize = 15;       %the patch size is set to be 15 x 15
padSize =  floor((patchSize-1)/2);
newSize = 500;      %Size of the image
intialRegions = 5;    %number of regions for segmentation
OutputPath = './Results/';   % Path for saving output images

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
t0 = 0.1;
r = win_size*4;
eps = 10^-6;
l = 10^-4;
%image = double(imread('.\underwater\8.jpg'))/255;
%figure('name', 'input'), imshow(image);
 
Udark = get_underwater_dark_channel(image, win_size);
% 显示图像暗通道
%figure('name', 'dark channel'),imshow(Udark);

Atom  = get_atomsphere(image, Udark); 

t = 1 - get_underwater_dark_channel(image ./ Atom, win_size);

%trans_est = guidedfilter(double(rgb2gray(image)), t, r, eps);
trans_est = softmatting(image, t, l);
%figure('name', 't'), imshow(trans_est);
%figure,imagesc(trans_est), axis image, truesize; colorbar

max_trans_est = repmat(max(trans_est, 0.1), [1, 1, 3]);


% 求解清晰图像
% J = (I-A)/max(t,t(0)) + A

result = ( (image - Atom)./max_trans_est )+ Atom;

toc; % 计时结束

    %Save Image
    savepath = strcat(OutputPath,imgname, '.png');
    imwrite(result,savepath);
    
    
end
%figure('name', 'output'); imshow(result);
