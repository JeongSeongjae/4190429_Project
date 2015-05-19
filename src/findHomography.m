function tform = findHomography(I1, I2)
    clear all;
    I1 = imread('../data/sample1.JPG');
    I2 = imread('../data/sample2.JPG');
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);

    % Find the SURF features.
    points1 = detectSURFFeatures(I1);
    points2 = detectSURFFeatures(I2);

    % Extract the features.
    [f1, vpts1] = extractFeatures(I1, points1);
    [f2, vpts2] = extractFeatures(I2, points2);

    % Retrive the locations of matched points. The SURF feature vectors are already normalized.
    indexPairs = matchFeatures(f1, f2, 'Prenormalized', true);
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));

    % Display the matching points.
    figure; showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
    legend('matched points 1', 'matched points 2');
    title('Matched SURF points, including outliers');

    % Exclude the outliers, and compute the transformation matrix.
    [tform, inlierPts1, inlierPts2] = estimateGeometricTransform(matchedPoints1, matchedPoints2, 'similarity');
    figure; showMatchedFeatures(I1, I2, inlierPts1, inlierPts2);
    legend('matched points 1', 'matched points 2');
    title('Matched inlier points');

    % Warp image
    outputView = imref2d(size(I1));
    Ir = imwarp(I2, tform, 'OutputView', outputView);
    figure; imshow(Ir); title('Warped Image');
end
