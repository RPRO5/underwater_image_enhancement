function [ JRDark,JRSDark] = Red_channel(im)
[height,width,~]=size(im);
patchsize=3;
padsize=1;

%%
im(:,:,1)=1-im(:,:,1);
imJ=padarray(im,[padsize,padsize],Inf);
JRDark=zeros(height,width);

imsize=height*width;
imvector=reshape(im,imsize,3);
maxvector=max(imvector,[], 2);
minvector=min(imvector,[],2);
im_sat=(maxvector-minvector)./maxvector;
lamda=1-mean(im_sat(:));
im_sat=im_sat*lamda;
im_sat=reshape(im_sat, height,width);

ims=cat(4,im(:,:,1),im(:,:,2),im(:,:,3),im_sat);
imS=padarray(ims,[padsize,padsize],Inf);
JRSDark=JRDark;

for j=1:height
    for i=1:width
        patch=imJ(j:(j+patchsize-1),i:(i+patchsize-1),:);
        patch1=imS(j:(j+patchsize-1),i:(i+patchsize-1),:);
        JRDark(j,i)=min(patch(:));
        JRSDark(j,i)=min(patch1(:));
    end
end
end


