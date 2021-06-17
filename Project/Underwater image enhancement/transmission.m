function [ trans ] =transmission(im,A)
im3=zeros(size(im));
w=0.95;
for ind=1:3
    if ind==1
    im3(:,:,ind)=w.*(im(:,:,ind)./(1-A(ind)));
    else
      im3(:,:,ind)=im(:,:,ind)./A(ind);  
    end
end

[ JDarks,Adaptivedark] =Red_channel(im3); 

trans=1-Adaptivedark;