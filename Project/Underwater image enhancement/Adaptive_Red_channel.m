function [ JDarks,Adaptivedark] = Adaptive_Red_channel(im,L,N,avgIntern)

[height,width,~]=size(im);

JDarks = zeros(height,width, N);
for k=1:N
    if(avgIntern(k)>=230)
        patchsize = 19;
    elseif(avgIntern(k)>=120)
        patchsize = 15;
    elseif(avgIntern(k)>=80)
        patchsize = 11;
    else
        patchsize = 5;
    end
    
padsize=(patchsize-1)/2;

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

 JDarks(:,:,k) = JRDark;
end
Adaptivedark = zeros(height,width);
for k=1:N
    S=(L==k);
    Darktemp = JDarks(:,:,k);
    Adaptivedark(S) = Darktemp(S);
end











