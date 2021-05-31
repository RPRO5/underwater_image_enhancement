%% Title: Low-Complexity Algorithm for Contrast Enhancement (LCACE)

%% Created by Zohair Al-Ameen.
% Department of Computer Science, 
% College of Computer Science and Mathematics,
% University of Mosul, 
% Mosul, Nineveh, Iraq

%% Please report bugs and/or send comments to Zohair Al-Ameen.
% Email: qizohair@uomosul.edu.iq

%% When you use this code or any part of it, please cite the following article:  
% Zohair Al-Ameen, and Zaman Awni Hasan, 
% "A Low-Complexity Algorithm for Contrast Enhancement of Digital Images," 
% International Journal of Image, Graphics and Signal Processing, vol. 10, no. 2, (2018): pp. 60-67. DOI: 10.5815/ijigsp.2018.02.07
%% INPUTS
% x --> is a given low-contrast image
% L -- > controls the amount of contrast enhancement

%% OUTPUT
% res --> a contrast-enhanced image.


%% Starting implementation %%
clear all; clc; close all;

trainData = imageSet('./u45 dataset','recursive');
patchSize = 15;     %the patch size is set to be 15 x 15
padSize =  floor((patchSize-1)/2);
newSize = 500; %Size of the image
intialRegions = 5; %number of regions for segmentation
OutputPath = './u45/'; % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

    %Pre-Processing
    x = imresize(img, [newSize,newSize]);
x = double(x)/255.0;
L = 0.9; 
tic; res = LCACE(x, L); toc;
%figure; imshow(res);title('Processed by LCACE')
savepath = strcat(OutputPath,imgname, '.png');
%     savepath = strcat(OutputPath,imgname, '.jpg');
    imwrite(res,savepath);
end
% imwrite(res,'1_LCACE_L0.9.jpg')