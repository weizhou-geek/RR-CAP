function [Q_sim,Q_hist] = CalSaliency(img1,img2)
%Input : (1) img1: the reference image
%        (2) img2: the distorted image
%Output: (1) Q:    the quality score
%        (2) qMap: the quality map
%Usage:  Two test RGB or gray images: img1 and img2, whose dynamic range is 0-255
%        [Q,qMap] = SIRR(img1,img2);

%% img1 reference; img2 distorted
if size(img1,3)==3
    img1 = rgb2gray(img1);
end
if size(img2,3)==3
    img2 = rgb2gray(img2);
end


%% Saliency detection
% Image signature based saliency map
sMap1 = calcSalency(img1,16);
sMap2 = calcSalency(img2,16);

%% Saliency similarity
% SSIM between sMap1 and sMap2
win  = fspecial('gaussian',3,9);
mu1 = filter2(win, sMap1, 'valid');
mu2 = filter2(win, sMap2, 'valid');
mu1_sq  = mu1.*mu1;
mu2_sq  = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(win, sMap1.*sMap1, 'valid') - mu1_sq;
sigma2_sq = filter2(win, sMap2.*sMap2, 'valid') - mu2_sq;
sigma12   = filter2(win, sMap1.*sMap2, 'valid') - mu1_mu2;
c1 = 10;
c2 = 10;
qMap = ((2*mu1_mu2 + c1).*(2*sigma12 + c2))./((mu1_sq + mu2_sq + c1).*(sigma1_sq + sigma2_sq + c2));
qMap = abs(qMap);
Q_sim = mean2(qMap);

sMap1_hist=imhist(sMap1);
sMap2_hist=imhist(sMap2);
Q_hist=corr(sMap1_hist,sMap2_hist);

%% Calculating saliency
function sal = calcSalency(img,d)
lpf  = ones(2,2);
lpf  = lpf/sum(lpf(:));
img = imfilter(img,lpf,'symmetric','same');
img = img(1:d:end,1:d:end);
img = double(img)/255;
img = sign(dct2(img));
index = find(img==0);
if ~isempty(index)
    img(index)=1;
end
sal  = idct2(img).^2;


