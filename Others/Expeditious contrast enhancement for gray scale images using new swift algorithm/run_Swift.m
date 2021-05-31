%% Title: Swift Algorithm for Contrast Enhancement

%% Created by Zohair Al-Ameen.
% Department of Computer Science, 
% College of Computer Science and Mathematics,
% University of Mosul, 
% Mosul, Nineveh, Iraq

%% Please report bugs and/or send comments to Zohair Al-Ameen.
% Email: qizohair@uomosul.edu.iq

%% When you use this code or any part of it, please cite the following article:  
% Zohair Al-Ameen. 
% "Expeditious Contrast Enhancement for Grayscale Images Using a New Swift Algorithm." 
% Statistics, Optimization & Information Computing, vol. 6, no. 4, (2018): pp. 577-587. DOI: 10.19139/soic.v6i4.436
%% INPUTS
% x1 --> is a given low-contrast image
% r -- > controls the amount of contrast enhancement

%% OUTPUT
% out --> contrast-enhanced image


%% Starting implementation %%
%clear all; clc; close all;

%x1=im2double(imread('1.jpg'));
%figure; imshow(x1); title('Orignal')
clc;
clear all;
close all;

trainData = imageSet('./u45 dataset','recursive');

newSize = 500;      %Size of the image
OutputPath = './u45/';   % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

%    %Pre-Processing
    img = imresize(img, [newSize,newSize]);
     image=double(img);
     image=image./255;

r = 1.5;
tic; out = Swift_Algorithm(image, r); toc;
%figure; imshow(out); title('Enhanced by Swift Algorithm')
% imwrite(out,'swift_out.jpg')

 savepath = strcat(OutputPath,imgname, '.png');
    imwrite(out,savepath);
    
    
end