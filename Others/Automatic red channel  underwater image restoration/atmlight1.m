function [ A ] = atmLight1( im, JRDark )
%基本操作均与atmLight函数相同
[height, width, ~]=size(im);
imsize=height*width;
numpx=floor(imsize/1000);
JRDarkvec=reshape(JRDark,imsize,1);
ImVec=reshape(im,imsize,3);
[JDarkvec,indices]=sort(JRDarkvec);
indices=indices(imsize-numpx+1:end);
%不同之处在于其最终选择最小值作为水下光强
min=Inf;
for ind=1:numpx
    temp=ImVec(indices(ind),:);
    if temp(1)<min
        min=temp(1);
        A=temp;
    end
end





