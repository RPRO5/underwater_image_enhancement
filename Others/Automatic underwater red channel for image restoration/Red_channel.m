function [ JRDark,JRSDark] = Red_channel(im)
[height,width,~]=size(im);
patchsize=7;
padsize=3;
im(:,:,1)=1-im(:,:,1);%得到红通道图像
imJ=padarray(im,[padsize,padsize],Inf);%扩展边缘
JRDark=zeros(height,width);

imsize=height*width;
imvector=reshape(im,imsize,3);%对图像进行重新定型
maxvector=max(imvector,[], 2);%得到RGB三层中的最大值
minvector=min(imvector,[],2);%得到RGB三层中的最小值
im_sat=(maxvector-minvector)./maxvector;%得到初步的sat值
lamda=1-mean(im_sat(:));%根据论文lamda可设定为1-sat的平均值
im_sat=im_sat*lamda;%得到优化后的sat值
im_sat=reshape(im_sat, height,width);%将sat重新定型为和图像大小相同的矩阵

ims=cat(4,im(:,:,1),im(:,:,2),im(:,:,3),im_sat);%获得带sat层的图像矩阵
imS=padarray(ims,[padsize,padsize],Inf);%扩展边缘
JRSDark=JRDark;
%滤波得到红通道和带sat值的通道矩阵
for j=1:height
    for i=1:width
        patch=imJ(j:(j+patchsize-1),i:(i+patchsize-1),:);
        patch1=imS(j:(j+patchsize-1),i:(i+patchsize-1),:);
        JRDark(j,i)=min(patch(:));%不带sat值
        JRSDark(j,i)=min(patch1(:));%带有sat值
    end
end
end


