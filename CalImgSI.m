function [SI] = CalImgSI(img)

if ndims(img) == 3
    img = rgb2gray(img);
end

h = [-1,0,1;-2,0,2;-1,0,1];
v = [1,2,1;0,0,0;-1,-2,-1];

Gx = filter2(h,img,'valid');
Gy = filter2(v,img,'valid');

G  = sqrt(Gx.^2 + Gy.^2);
SI = std(reshape(G,1,[]));