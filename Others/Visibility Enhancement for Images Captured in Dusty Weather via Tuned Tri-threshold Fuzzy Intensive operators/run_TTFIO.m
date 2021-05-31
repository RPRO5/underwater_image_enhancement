%% Title: Visibility Enhancement for Dusty Images
%% Created by: Zohair Al-Ameen.
% Department of Computer Science, 
% College of Computer Science and Mathematics,
% University of Mosul, IRAQ
%% Please report bugs and/or send comments to Zohair Al-Ameen.
% Email: qizohair@uomosul.edu.iq
%% When you Use this Code or any Part of it, Please Cite the following Article:  
% Zohair Al-Ameen, "Visibility Enhancement for Images Captured in 
% Dusty Weather via Tuned Tri-threshold Fuzzy Intensification Operators",
% International Journal of Intelligent Systems and Applications, 
% vol. 8, no. 8, (2016): pp. 10-17. DOI: 10.5815/ijisa.2016.08.02 
%% License
% Copyright (c) 2017 Zohair Al-Ameen
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files, to deal
% in the Software without restriction, subject to the following conditions:
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
% The Software is provided "as is", without warranty of any kind.
%% Ver 2.0: January 2017

clear all;clc;
traindataPath = './u45 dataset/';
trainData = imageSet(traindataPath,'recursive');
newSize = 500; %Size of the image
OutputPath = './u45/';
% GroundTruth = imageSet('GroundTruth','recursive');
% 
% img1 = read(trainData,1);
% imshow(img1)
% path = char(trainData.ImageLocation(1));
% [~,name,~] = fileparts(path) ;

for count = 1:trainData.Count
    img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;
    %% Pre-Processing
    img = imresize(img, [newSize,newSize]);
x = double(img)/255.0;
zeta=.5; 
%x=im2double(imread('2.jpg')); 
%figure; imshow(x)
x_R=x(:,:,1); x_G=x(:,:,2); x_B=x(:,:,3);
tao_R=.5; tao_G=.4; tao_B=.6;
R=(TTFIO(x_R,tao_R,zeta));
G=(TTFIO(x_G,tao_G,zeta));
B=(TTFIO(x_B,tao_B,zeta));
out=cat(3,R,G,B);
%figure; imshow(out)
savepath = strcat(OutputPath,imgname, '.png');
%     savepath = strcat(OutputPath,imgname, '.jpg');
    imwrite(out,savepath);
end