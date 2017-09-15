%This converts a feature matrix to an indexed image by cluster label, which is visualized and returned.
function [cimg] = grid_wavecluster_output(observations, cluster_labels, weights)    
    if (any(observations(:) < 1))
        %Center around 1.
        observations = observations - repmat(min(observations, [], 1), size(observations, 1), 1) + 1;
    end
    
    csize = ceil(max(observations, [], 1));
    ocell = num2cell(observations, 1);
    cidx = round(sub2ind(csize, ocell{:}));
    
    cimg = zeros(1, prod(csize(:)));
    cimg(cidx) = cluster_labels;
    cimg = reshape(cimg, csize);

    %Weights are used to clip edges. If none given, don't clip.
    if (nargin >= 3)
        cimg = cimg .* (weights > 0);
    end

%    imshow(gray2ind(cimg));
end