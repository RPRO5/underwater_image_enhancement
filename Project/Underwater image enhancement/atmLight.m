function A = atmLight(im, JDark)

[height, width, ~] = size(im);
imsize = width * height;

numpx = floor(imsize/1000);
JDarkVec = reshape(JDark,imsize,1);
ImVec = reshape(im,imsize,3);

[JDarkVec, indices] = sort(JDarkVec);
indices = indices(imsize-numpx+1:end);

atmSum = zeros(1,3);
max=0;

for ind=1:numpx
   temp=sum( ImVec(indices(ind),:));
   if temp>max
   max=temp;
   A=ImVec(indices(ind),:);
   end
end
