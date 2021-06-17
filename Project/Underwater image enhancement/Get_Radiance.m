function [ J ] =Get_Radiance( im, A,t0,trans )

J_r=(im(:,:,1)-A(1))./max(trans,t0)+A(1)*(1-A(1));
J_g=(im(:,:,2)-A(2))./max(trans,t0)+A(2)*(1-A(2));
J_b=(im(:,:,3)-A(3))./max(trans,t0)+A(3)*(1-A(3));

J_r=(J_r-min(J_r(:)))/(max(J_r(:))-min(J_r(:)));
J_g=(J_g-min(J_g(:)))/(max(J_g(:))-min(J_g(:)));
J_b=(J_b-min(J_b(:)))/(max(J_b(:))-min(J_b(:)));

J=cat(3,J_r,J_g,J_b);

end

