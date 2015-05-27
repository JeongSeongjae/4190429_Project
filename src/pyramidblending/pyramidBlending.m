function [imgo imgo1] = pyramidBlending(imga, imgb, facea, faceb)
    %{
        masked area of imga will be stitched to imgb
    %}
    %imga = im2double(inFace);
    %imgb = im2double(switchingFace);
    %imga = imresize(imga,[size(imgb,1) size(imgb,2)]);
    [M N ~] = size(imga);

    v = 230;
    level = 5;
    limga = genPyr(imga,'lap',level); % the Laplacian pyramid
    limgb = genPyr(imgb,'lap',level);

    % [x y height width]
    x1 = facea(1); y1 = facea(2); h1 = facea(3); w1 = facea(4);
    x2 = faceb(1); y2 = faceb(2); h2 = faceb(3); w2 = faceb(4);
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
    %figure; imshow(inFace); title('inFace');
    %figure; imshow(switchingFace); title('switchingFace');
    imgo = pyrReconstruct(limgo);
    %figure,imshow(imgo); title('pyramid'); % blend by pyramid
    imgo1 = maska.*imga+maskb.*imgb;
    %figure,imshow(imgo1); title('feathering'); % blend by feathering
end
