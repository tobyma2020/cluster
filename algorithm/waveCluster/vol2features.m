%Returns a weighted cluster feature matrix for use with WaveCluster.
%The input is an n-dimensional volume.
function [features, weights] = vol2features(vol)
    %Store the indices so we can use a vectorized ndgrid call to make the grid.
    sizecell = cell(1, ndims(vol));
    for dimidx = 1:ndims(vol)
       sizecell{dimidx} = (1:size(vol, dimidx));
    end

    [feature_dims{1:ndims(vol)}] = ndgrid(sizecell{:});
    for dimidx = 1:ndims(vol)
        feature_dims{dimidx} = feature_dims{dimidx}(:);
    end
    
    features = cat(2, feature_dims{:});
    
    clear sizecell feature_dims;
    
    weights = vol(:);
end
