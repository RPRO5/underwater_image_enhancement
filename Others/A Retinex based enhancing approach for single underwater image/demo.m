
clc;
clear all;
close all;

trainData = imageSet('./Oceandark dataset','recursive');
newSize = 500;      %Size of the image
OutputPath = './ocean/';   % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

%    %Pre-Processing
    img = imresize(img, [newSize,newSize]);
 

output = underwater(img);
savepath = strcat(OutputPath,imgname, '.png');
    imwrite(output,savepath);
    
    
end
%figure,imshow(input), title('original image');
%figure,imshow(output),title('enhanced image');