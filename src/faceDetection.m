function [bboxes] = faceDetection(I)
    faceDetector = vision.CascadeObjectDetector;
    bboxes = step(faceDetector, I);
    IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
    figure, imshow(IFaces), title('Detected faces');
end
