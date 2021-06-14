function [ J ] =dehazing( im, A,t0,trans )
%最终的计算函数，利用原图像，水下光强，水下折射率求出最终的清晰图像，参数t0为防止t值过小的阈值参数
%获得初步清晰图像，对A值采用A*(1-A)优化
J_r=(im(:,:,1)-A(1))./max(trans,t0)+A(1)*(1-A(1));
J_g=(im(:,:,2)-A(2))./max(trans,t0)+A(2)*(1-A(2));
J_b=(im(:,:,3)-A(3))./max(trans,t0)+A(3)*(1-A(3));
%结果进行归一化操作，得到最终的结果
J_r=(J_r-min(J_r(:)))/(max(J_r(:))-min(J_r(:)));
J_g=(J_g-min(J_g(:)))/(max(J_g(:))-min(J_g(:)));
J_b=(J_b-min(J_b(:)))/(max(J_b(:))-min(J_b(:)));
J=cat(3,J_r,J_g,J_b);

end

