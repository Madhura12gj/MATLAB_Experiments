im = imread('2_code.jpg');
gray = rgb2gray(im);%converting into gray
denoise = imfilter(gray,ones(3,3)/9,'same');% removing noise and performing averaging with a 3x3
%thresh = graythresh(gray); %Global Threshold
%b1 = imbinarize(gray, thresh);
%Local Threshold
b2 = imbinarize(denoise ,'adaptive','ForegroundPolarity','dark');%binarizing the image
subplot(1,2,1)
imshow(im), title('input image')
subplot(1,2,2)
imshow(b2), title('Local Threshold')%showing the local threshold











