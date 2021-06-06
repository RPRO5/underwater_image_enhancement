%%%%%%
% method described on Color Balance and Fusion for Underwater Image 
% Enhancement by Codruta O. Ancuti , Cosmin Ancuti, Christophe De 
% Vleeschouwer , and Philippe Bekaert 

close all;
clear all;
clc;


%% Load the image 
clear all; clc; close all;

trainData = imageSet('./u45 dataset','recursive');

newSize = 500; %Size of the image
OutputPath = './u45/';%'./Color Balance and Fusion for Underwater Image Enhancement/'; % Path for saving output images

for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

    %Pre-Processing
    x = imresize(img, [newSize,newSize]);
    rgbImage = double(x)/255.0;
    grayImage = rgb2gray(rgbImage); 



%% White Balance
I=rgbImage;
%I = cat(3, Irc, Ig, Ibc);
I_lin = rgb2lin(I);
percentiles = 5;
illuminant = illumgray(I_lin,percentiles);
I_lin = chromadapt(I_lin,illuminant,'ColorSpace','linear-rgb');
Iwb = lin2rgb(I_lin);



%%% Multi-Scale fusion. 

%% Gamma Correction
Igamma = imadjust(Iwb,[],[],2);



%% image sharpening
sigma = 20;
Igauss = Iwb;
N = 30;
for iter=1: N
   Igauss =  imgaussfilt(Igauss,sigma);
   Igauss = min(Iwb, Igauss);
end

gain = 1; %in the paper is not mentioned, but sometimes gain <1 is better. 
Norm = (Iwb-gain*Igauss);
%Norm
for n = 1:3
   Norm(:,:,n) = histeq(Norm(:,:,n)); 
end
Isharp = (Iwb + Norm)/2;


%% weights calculation

% Lapacian contrast weight 
Isharp_lab = rgb2lab(Isharp);
Igamma_lab = rgb2lab(Igamma);

% input1
R1 = double(Isharp_lab(:, :, 1)) / 255;
% calculate laplacian contrast weight
WC1 = sqrt((((Isharp(:,:,1)) - (R1)).^2 + ...
            ((Isharp(:,:,2)) - (R1)).^2 + ...
            ((Isharp(:,:,3)) - (R1)).^2) / 3);
% calculate the saliency weight
WS1 = saliency_detection(Isharp);

% calculate the saturation weight

WSAT1 = sqrt(1/3*((Isharp(:,:,1)-R1).^2+(Isharp(:,:,2)-R1).^2+(Isharp(:,:,3)-R1).^2));




% input2
R2 = double(Igamma_lab(:, :, 1)) / 255;
% calculate laplacian contrast weight
WC2 = sqrt((((Igamma(:,:,1)) - (R2)).^2 + ...
            ((Igamma(:,:,2)) - (R2)).^2 + ...
            ((Igamma(:,:,3)) - (R2)).^2) / 3);
% calculate the saliency weight
WS2 = saliency_detection(Igamma);


% calculate the saturation weight
WSAT2 = sqrt(1/3*((Igamma(:,:,1)-R1).^2+(Igamma(:,:,2)-R1).^2+(Igamma(:,:,3)-R1).^2));


% calculate the normalized weight
W1 = (WC1 + WS1 + WSAT1+0.1) ./ ...
     (WC1 + WS1 + WSAT1 + WC2 + WS2 + WSAT2+0.2);
W2 = (WC2 + WS2 + WSAT2+0.1) ./ ...
     (WC1 + WS1 + WSAT1 + WC2 + WS2 + WSAT2+0.2);
 
 



% %% Multi scale fusion.
 img1 = Isharp;
 img2 = Igamma;

% calculate the gaussian pyramid
level = 1;
Weight1 = gaussian_pyramid(W1, level);
Weight2 = gaussian_pyramid(W2, level);

% calculate the laplacian pyramid
% input1
R1 = laplacian_pyramid(Isharp(:, :, 1), level);
G1 = laplacian_pyramid(Isharp(:, :, 2), level);
B1 = laplacian_pyramid(Isharp(:, :, 3), level);
% input2
R2 = laplacian_pyramid(Igamma(:, :, 1), level);
G2 = laplacian_pyramid(Igamma(:, :, 2), level);
B2 = laplacian_pyramid(Igamma(:, :, 3), level);

% fusion
for k = 1 : level
   Rr{k} = Weight1{k} .* R1{k} + Weight2{k} .* R2{k};
   Rg{k} = Weight1{k} .* G1{k} + Weight2{k} .* G2{k};
   Rb{k} = Weight1{k} .* B1{k} + Weight2{k} .* B2{k};
end

% reconstruct & output
R = pyramid_reconstruct(Rr);
G = pyramid_reconstruct(Rg);
B = pyramid_reconstruct(Rb);
fusion = cat(3, R, G, B);


    savepath = strcat(OutputPath,imgname, '.png');
    imwrite(fusion,savepath);
end
