function [ trans ]= Adaptivetransmission(im,A,L,N,avgIntern)

im3=zeros(size(im));
omega=0.94;

for ind=1:3
    if ind==1
    im3(:,:,ind)=im(:,:,ind)./(1-A(ind));
    else
      im3(:,:,ind)=im(:,:,ind)./A(ind);  
    end
end
[ JDarks,Adaptivedark] = Adaptive_Red_channel(im3,L,N,avgIntern);%

im3 = im3.*255;

Adaptivedark = double(Adaptivedark);
Adaptivedark = Adaptivedark./255;

AdaptiveOmega = zeros(size(Adaptivedark,1),size(Adaptivedark,2));
for k=1:N
    if(avgIntern(k)>=220)
        omega = 0.85;
    elseif(avgIntern(k)>=120)
        omega = 0.8;
    elseif(avgIntern(k)>=100)
        omega = 0.75;
    elseif(avgIntern(k)>=80)
        omega = 0.7;
    else
        omega = 0.65;
    end
    S=(L==k);
    AdaptiveOmega(S) = omega;
end

for ind=1:3
    if ind==1
    imA(:,:,ind)=AdaptiveOmega.*(im(:,:,ind)./(1-A(ind)));
    else
      imA(:,:,ind)=im(:,:,ind)./A(ind);  
    end
end
[ JDarks,Adaptivedark1] = Adaptive_Red_channel(imA,L,N,avgIntern);


trans=1-Adaptivedark1;