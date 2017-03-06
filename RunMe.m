% MATLAB script for Assessment Item-1
close all;

%%
%Step-1: Load input image
%Read in the image
I = imread('AssignmentInput.jpg');
figure;
%Display the image
imshow(I);
title('Step-1: Load input image');
%%

%Step-2: Conversion of input image to grayscale
figure;
%Convert the image to grayscale
I = rgb2gray(I);
%display the image
imshow(I);
title('Step-2: Conversion of input image to grayscale');

%%
% Step-3: Noise removal
figure;
%Using median filter to remove salt and pepper noise
I = medfilt2(I,[3,3], 'Zeros');
%display the image
imshow(I);
title('Step-3: Removal of noise from input image');

%%
%Step-4: Sharpen image
figure;
%Use unsharp to sharpen image edges
I = imsharpen(I, 'Radius', 1, 'Amount', 1);
%Enhance the contrast of the image
I = imadjust(I);
%Display the image
imshow(I);
title('Step-4: Enhancement of input image');

%%
%Step-5: Segment background and foreground
figure;
%Get the gray threshold for the image
thresh = graythresh(I);
%Convert the image to binary using threshold 0.8
bw = im2bw(I, 0.8);
%Reverse the whites and blacks in the image
I = imcomplement(bw);
%Display the image
imshow(I);
title('Step-5: Segment the image into foreground and background');

%%
%Step-6: Remove unneccesary pixels
figure;
%Remove any objects that have less than 50 pixels
I = bwareaopen(I, 50);
%Create a structuring element 'diamond' with a radius of 1
se = strel('diamond',2);
%Erode the binary image using the created structuring element
I = imerode(I, se);
%Remove any objects that have less than 50 pixels
I = bwareaopen(I, 50);
%Create a different structuring element 'diamond' with a radius of 2
se = strel('diamond',2);
%Dilate the binary image using the created structuring element
I = imdilate(I, se);
%Display the image
imshow(I);
title('Step-6: Use morphological processing to remove unneccesary pixels');

%%
%Step-7: Segment Starfish
figure;
%Get the connected components from the image
cc = bwconncomp(I);
%Get the area of the connected components
s = regionprops(cc, 'Area', 'Perimeter');
%Loop through connected components
for i = 1:cc.NumObjects
    %Get area of current connected component
    area = s(i).Area;
    %Get perimeter of current connected component
    perimeter = s(i).Perimeter;
    %Work out the roundness of current connected component
    roundness = 4*pi*area/perimeter^2;
    %If roundess is more round or less round than star
    if roundness > 0.2392 || roundness < 0.2108
        %Delete the current connect component
        I(cc.PixelIdxList{i}) = 0;
    end
end
%Remove objects that have an area smaller or larger than the smallest or largest starfish
%I = xor(bwareaopen(I, 1052), bwareaopen(I, 1248));
%Display the image
imshow(I);
title('Step-7: Segment the Starfish');