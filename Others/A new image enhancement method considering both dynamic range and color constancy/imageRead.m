function imageRead(address)

inImg = imread(address);
if length(size(inImg))==3
    hsvMain(inImg);
else
    grayMain(inImg);
end