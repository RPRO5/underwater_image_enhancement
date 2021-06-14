function dark = darkChannel(im2)
[height, width, ~] = size(im2);
patchSize = 3; 
padSize = 1; 
dark = zeros(height, width); 
imJ = padarray(im2, [padSize padSize], Inf);%扩展边缘
for j = 1:height
    for i = 1:width
        patch = imJ(j:(j+patchSize-1), i:(i+patchSize-1),:);%选取范围
        dark(j,i) = min(patch(:));%得到最小值作为暗通道的值
     end
end
