function [bboxes] = faceDetection(I)
    %{
        bbox : (M X 4) matrix defining M bounding boxes, containing [x y width height].
    %}
    faceDetector = vision.CascadeObjectDetector;
    bboxes = step(faceDetector, I);
    IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
    figure, imshow(IFaces), title('Detected faces');
end
