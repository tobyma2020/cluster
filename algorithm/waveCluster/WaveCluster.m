%Runs the WaveCluster algorithm on the input data. Returns cluster labels.
%Accepts a dataset of observations in the rows and features (incl. x,y
%coordinates) in the columns, an optional vector of observation weights,
%the number of cells to partition into, a count threshold above which a cell is
%considered "significant", a wavelet decomposition level to analyze at, and the
%name of the wavelet to use.
%If useSWT is nonzero, a stationary wavelet transform will be used in place
%of a discrete wavelet transform. This improves performance on small datasets.

%The threshold, level, and wavelet name are optional; defaults are the 10%
%level of the dataset, 1, and the 2,2 biorthogonal wavelet, respectively.
%The cell size may be a scalar or a vector of the same size as the number
%of features in the data matrix.
function [cluster_labels, clustergrid, counts, datacellindices, wdata, sigcells] = WaveCluster(data, weights, num_cells, densitythreshold, level, wavename, useSWT)
    tic

    [sigcells, datacellindices, counts, wdata] = WaveCluster_Preprocess(data, weights, num_cells, densitythreshold, level, wavename, useSWT);
    
    %Find and label connected components.
    clustergrid = bwlabeln(sigcells);

    %Using the lookup table, map points to the grid to find their clusters.
    linidx = num2cell(datacellindices, 1);
    cluster_labels = clustergrid(sub2ind(size(clustergrid), linidx{:}));
    
    disp(['Discovered ' num2str(max(cluster_labels)) ' clusters.']);
    toc
end