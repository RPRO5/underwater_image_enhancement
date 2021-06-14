%function [im1] = underwater_final(im)
%设定t的阈值参数，和导向滤波优化参数
clear all; clc; close all;

trainData = imageSet('./Dataset','recursive');
newSize = 500; %Size of the image
OutputPath = './Results/'; % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

    %Pre-Processing
    img = imresize(img, [newSize,newSize]);
    im_haze = double(img)/255.0;
t0=0.1;
r = 15;
res = 0.001;
%初始化图像
%im_haze=im2double(im);
%对图像进行红通道滤波
[ JRDark,JRSDark] = Red_channel(im_haze);
%使用不带sat值的红通道矩阵得到A值
 atmospheric=atmLight(im_haze,JRDark);
%使用A值得到最终的t值，并使用导线滤波优化t
[ trans ] =transmittion(im_haze,atmospheric);
 trans = guided_filter(rgb2gray(im_haze), trans, r, res);
 %得到最终的归一化结果
im1 =dehazing(im_haze, atmospheric,t0,trans);
savepath = strcat(OutputPath,imgname, '.png');
    imwrite(im1,savepath);
    
    
end
