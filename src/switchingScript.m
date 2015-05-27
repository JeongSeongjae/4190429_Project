clear all;

% Add subdirectory
addpath ./pyramidblending/

% Read image and resize
img1 = imread('../data/sample1_1.JPG');
img2 = imread('../data/sample1_2.JPG');

img1 = im2double(img1);
img2 = im2double(img2);
img1 = imresize(img1, [size(img2,1) size(img2,2)]);

% Align two image by using SURF and RANSAC
img2_warped = getWarpedImage(img1,img2);

% Get valid bboxes
bbox1 = faceDetection(img1);
bbox2 = faceDetection(img2_warped);

face1 = bbox1(1,:);
face2 = bbox2(1,:);

% Stitching img2_warped to img1
[img_pyramid img_feathering] = pyramidBlending(img2_warped, img1, face2, face1);

figure; imshow(img1); title('Input image 1');
figure; imshow(img2_warped); title('Input image 2 (warped)');
figure; imshow(img_pyramid); title('Pyramid');
figure; imshow(img_feathering); title('Feathering');
