clear all;clc
im = imread('00015.jpg');
%im = rgb2gray(im)
imshow(darkChannel(im)/255)
im = darkChannel(im)
sum(im(:))