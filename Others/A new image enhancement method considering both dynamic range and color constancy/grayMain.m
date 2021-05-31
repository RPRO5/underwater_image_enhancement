% clear all;
% clc;
function grayMain(inImg)
inhistR=imhist(inImg);
figure, imshow(inImg);
figure, imhist(inImg);
% inhistR=abs(inhistR-255);
%figure, imhist(inImg);
[m n l]=size(inImg);

inhistR=inhistR./(m*n);

for i=1:83
    img2 = imread(['database\',int2str(i),'.jpg']);
    img2=rgb2gray(img2);
    [a b c]=size(inImg);
    %x=imhist(img2(:,:,1))';
    x=imhist(img2)';
    p(i,:)=x./(a*b);
    %p(i,:)=imhist(img2(:,:,1))';
    minimum(i)=Jensen(p(i,:)+1,inhistR'+1);
end

[minim,index1]=min(minimum);
img2 = imread(['database\',int2str(index1),'.jpg']);
[a b c]=size(img2);
p(index1)=p(index1)*(a*b);
inImg=histeq(inImg, p(index1,:));  

figure, imshow(inImg);  
figure, imhist(inImg);
   
%psnr=PeakSignaltoNoiseRatio(inImg, g);


