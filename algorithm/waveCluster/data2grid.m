%Converts a dataset (obs. in rows, features in cols) to multidimensional grid format.
%Returns the counts in each grid cell (thus performs quantization as well).
%A scalar may be specified for an equal number of cells per dimension, or a
%vector may be specified for a different number of cells in each dimension.
function [counts, datacells] = data2grid(data, weights, num_cells)
    %If the data is not weighted, apply a weight of 1 to each grid cell.
    if (~exist('weights', 'var') || isempty(weights))
        weights = ones(size(data, 1), 1);
    end

    %Find the range of the grid.
    featuremin = min(data, [], 1);
    featuremax = max(data, [], 1);
    
    %Although the computations can be performed using a scalar, it's easier
    %to ensure a uniform vector for use with functions such as zeros.
    if (isscalar(num_cells))
        num_cells = repmat(num_cells, [1 size(data,2)]);
    end
    
    cellsize = (featuremax + 1 - featuremin) ./ num_cells;
    
    %Determine an appropriate repmat tiling to fit the num_cells matrix to
    %each element in the data matrix.
    tilesize = size(data);
    tilesize(2) = 1;        %num_cells is defined as a 1xsize(data, 2) vector.

    %Quantize the data to its cell index.
    %quant doesn't work very well with a vector of quantization values.
    datacells = floor((data - repmat(featuremin, tilesize)) ./ repmat(cellsize, tilesize)) + 1;

    counts = assign_cells(datacells, weights, num_cells);
%    counts = counts ./ sqrt(prod(cellsize)); %Theoretically this could
%    make the analysis more invariant to cell size, but doesn't seem to
%    work that well in practice.
end
