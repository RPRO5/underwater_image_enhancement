function [ trans ] =transmittion(im,A)
%根据获得的A值，利用公式计算最终的t值
im3=zeros(size(im));
%使用A值变化im
for ind=1:3
    if ind==1
    im3(:,:,ind)=im(:,:,ind)./(1-A(ind));
    else
      im3(:,:,ind)=im(:,:,ind)./A(ind);  
    end
end
%对变化后的im进行红通道滤波，得到带sat值的通道矩阵
[ JRDark,JRSDark] = Red_channel(im3);
%最终采用带sat值的通道矩阵计算t值
trans=1-JRSDark;



