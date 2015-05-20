function [out] = classifyFace(in)
    %{
        in : (M X 1) cell. M is number of group pictures.
             Each cell contains (N X 4) matrix, N is number of people.
        out : (M X N) matrix. Classified version of in.
    %}

    Error = sum((face1 - face2) .^ 2);
    [M N] = size(in);
    for i=1:M
    end
end
