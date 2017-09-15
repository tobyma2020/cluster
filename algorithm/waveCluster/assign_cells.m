%Assigns elements to cells and computes cell counts.
%Meant as a helper function; don't call directly unless you have a reason.
function [counts] = assign_cells(datacells, weights, num_cells)
    %This will expand the 2D matrix into a multidimensional structure (thus
    %no size() around num_cells)... num_cells is a vector.
    counts = zeros(num_cells);
    
    idxcell = num2cell(datacells, 1);
    countidx = sub2ind(size(counts), idxcell{:});
    for countpos = 1:length(countidx)
        %TODO: Vectorize.
        counts(countidx(countpos)) = counts(countidx(countpos)) + weights(countpos);
    end

    %Low-order: use sparse. High-order: use sptensor.
    %counts = sparse(counts);    %Most of the counts will be 0. This saves
    %memory.
end