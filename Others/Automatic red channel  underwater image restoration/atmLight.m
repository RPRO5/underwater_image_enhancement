function A = atmLight(im, JDark)
[height, width, ~] = size(im);
imsize = width * height;%得到单层像素点的个数

numpx = floor(imsize/1000);%确定选取范围
JDarkVec = reshape(JDark,imsize,1);%得到暗通道向量
ImVec = reshape(im,imsize,3);%得到图像向量

[JDarkVec, indices] = sort(JDarkVec);%暗通道排序获得索引
indices = indices(imsize-numpx+1:end); %确定要选取的像素点的位置

atmSum = zeros(1,3);
max=0;
%遍历选取范围，选择最大的像素点值作为A值
for ind=1:numpx
   temp=sum( ImVec(indices(ind),:));
   if temp>max
   max=temp;
   A=ImVec(indices(ind),:);
   end
end
