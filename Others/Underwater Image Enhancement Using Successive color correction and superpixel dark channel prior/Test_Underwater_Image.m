
% In = imread('put the name of the input image');
clc;
clear all;
close all;

trainData = imageSet('./u45 dataset','recursive');
patchSize = 15;     %the patch size is set to be 15 x 15
padSize =  floor((patchSize-1)/2);
intialRegions = 5; %number of regions for segmentation
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

J = Underwater_Image(image);

% figure;
% subplot(1,2,1), imshow(In), title('Input');
% subplot(1,2,2), imshow(J), title('Recovered Image');
savepath = strcat(OutputPath,imgname, '.png');
    imwrite(J,savepath);
    
    
end