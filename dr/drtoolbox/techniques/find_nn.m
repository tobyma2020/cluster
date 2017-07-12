function [D, ni] = find_nn(X, k)
%FIND_NN Finds k nearest neigbors for all datapoints in the dataset
%
%	[D, ni] = find_nn(X, k)
%
% Finds the k nearest neighbors for all datapoints in the dataset X.
% In X, rows correspond to the observations and columns to the
% dimensions. The value of k is the number of neighbors that is
% stored. The function returns a sparse distance matrix D, in which
% only the distances to the k nearest neighbors are stored. For
% equal datapoints, the distance is set to a tolerance value.
% The method is relatively slow, but has a memory requirement of O(nk).
%
%

% This file is part of the Matlab Toolbox for Dimensionality Reduction.
% The toolbox can be obtained from http://homepage.tudelft.nl/19j49
% You are free to use, change, or redistribute this code in any way you
% want for non-commercial purposes. However, it is appreciated if you 
% maintain the name of the original author.
%
% (C) Laurens van der Maaten, Delft University of Technology


	if ~exist('k', 'var') || isempty(k)
		k = 12;
    end
    
    % Perform adaptive neighborhood selection if desired
    if ischar(k)
        [D, max_k] = find_nn_adaptive(X);
        ni = zeros(size(X, 1), max_k);
        for i=1:size(X, 1)
            tmp = find(D(i,:) ~= 0);
            tmp(tmp == i) = [];
            tmp = [tmp(2:end) zeros(1, max_k - length(tmp) + 1)];
            ni(i,:) = tmp;
        end
    
    % Perform normal neighborhood selection
    else
        
        % Compute distances in batches
        n = size(X, 1);
        sum_X = sum(X .^ 2, 2);
        batch_size = round(2e7 ./ n);
        D = zeros(n, k);
        ni = zeros(n, k);
        for i=1:batch_size:n
            batch_ind = i:min(i + batch_size - 1, n);
            DD = bsxfun(@plus, sum_X', bsxfun(@plus, sum_X(batch_ind), ...
                                                   -2 * (X(batch_ind,:) * X')));
            [DD, ind] = sort(abs(DD), 2, 'ascend');
            D(batch_ind,:) = sqrt(DD(:,2:k + 1));
            ni(batch_ind,:) = ind(:,2:k + 1);
        end
        D(D == 0) = 1e-9;
        Dout = sparse(n, n);
        idx = repmat(1:n, [1 k])';
        Dout(sub2ind([n, n], idx,   ni(:))) = D;
        Dout(sub2ind([n, n], ni(:), idx))   = D;
        D = Dout;
    end
    