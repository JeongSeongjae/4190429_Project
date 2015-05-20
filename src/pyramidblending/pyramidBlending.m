function pyramidBlending(inFace, switchingFace)
    % TODO : this code need fix
    imga = im2double(inFace);
    imgb = im2double(switchingFace);
    imga = imresize(imga,[size(imgb,1) size(imgb,2)]);
    [M N ~] = size(imga);

    v = 230;
    level = 5;
    limga = genPyr(imga,'lap',level); % the Laplacian pyramid
    limgb = genPyr(imgb,'lap',level);

    bbox1 = faceDetection(imga);
    face1 = bbox1(1,:); % [x y height width]
    x1 = face1(1); y1 = face1(2); h1 = face1(3); w1 = face1(4);
    bbox2 = faceDetection(imgb);
    face2 = bbox2(1,:);
    x2 = face2(1); y2 = face2(2); h2 = face2(3); w2 = face2(4);
    maska = zeros(size(imga));
    maska(y1:y1+h1,x1:x1+w1,:) = 1;
    maskb = 1-maska;
    blurh = fspecial('gauss',30,15); % feather the border
    maska = imfilter(maska,blurh,'replicate');
    maskb = imfilter(maskb,blurh,'replicate');

    limgo = cell(1,level); % the blended pyramid
    for p = 1:level
        [Mp Np ~] = size(limga{p});
        maskap = imresize(maska,[Mp Np]);
        maskbp = imresize(maskb,[Mp Np]);
        limgo{p} = limga{p}.*maskap + limgb{p}.*maskbp;
    end
    figure; imshow(inFace); title('inFace');
    figure; imshow(switchingFace); title('switchingFace');
    imgo = pyrReconstruct(limgo);
    figure,imshow(imgo); title('pyramid'); % blend by pyramid
    imgo1 = maska.*imga+maskb.*imgb;
    figure,imshow(imgo1); title('feathering'); % blend by feathering
end
