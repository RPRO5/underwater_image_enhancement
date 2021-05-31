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
%% INPUTS
% image --> is a given degraded image
% tao --> is a predetermined thresholding parameter
% zeta -- > is a tuning parameter that is used to control the colors fidelity
%% OUTPUT
% out --> a processed image.
%% License
% Copyright (c) 2017 Zohair Al-Ameen
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files, to deal
% in the Software without restriction, subject to the following conditions:
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
% The Software is provided "as is", without warranty of any kind.
%% Ver 2.0: January 2017

function out = TTFIO(image, tao, zeta)
[row col]=size(image);
%% Calculating the Membership Function 
img = (image - min(image(:)))./(max(image(:)) - min(image(:)));
%% Applying Intensification Operators
for j = 1:row
    for k = 1:col
        if img(j,k) <= tao
            enhanced(j,k) = 2*img(j,k)^2;
        else
            enhanced(j,k) = 1-2*(1-img(j,k))^2;
        end
    end
end
%% Tuning the Output
out=((enhanced).^(tao+zeta));
