% contrast based method
function Isharp = ContrastApproach(img)
    rgbImage = img;
    grayImage = rgb2gray(rgbImage); 

    Ir = rgbImage(:,:,1);
    Ig = rgbImage(:,:,2);
    Ib = rgbImage(:,:,3);

    Ir_mean = mean(Ir);
    Ig_mean = mean(Ig); 
    Ib_mean = mean(Ib);

% Color compensation
    alpha = 0.5;
    Irc = Ir + alpha*(Ig_mean - Ir_mean);
    alpha = 0; % 0 does not compensates blue channel. 

    Ibc = Ib + alpha*(Ig_mean - Ib_mean);
 
% White Balance

    I = cat(3, Irc, Ig, Ibc);
    I_lin = rgb2lin(I);
    percentiles = 5;
    illuminant = illumgray(I_lin,percentiles);
    I_lin = chromadapt(I_lin,illuminant,'ColorSpace','linear-rgb');
    Iwb = lin2rgb(I_lin);
 

% Gamma Correction
    Igamma = imadjust(Iwb,[],[],2);

% image sharpening
    sigma = 30;
    Igauss = Igamma;
    N = 50;
   for iter=1: N
        Igauss =  imgaussfilt(Igauss,sigma);
        Igauss = min(Iwb, Igauss);
   end

   gain = 1; 
   Norm = (Iwb-gain*Igauss);

   for n = 1:3
        Norm(:,:,n) = histeq(Norm(:,:,n)); 
   end
   Isharp = (Iwb + Norm)/2;
   
end