function apd = Avg_PerpenDist(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % erode element  
    s = cat(3, [0 0 0 ; 0 1 0 ; 0 0 0], [0 1 0 ; 1 1 1 ; 0 1 0], [0 0 0 ; 0 1 0 ; 0 0 0]);  
    % generate boundary  
    Boundary_SEG = logical(SEG) & ~imerode(logical(SEG), s);  
    Boundary_GT = logical(GT) & ~imerode(logical(GT), s);  
    % distance to nearest boundary point  
    Dist_GT = bwdist(Boundary_GT, 'euclidean');  
    % distance to another boundary  
    min_S2G = Dist_GT( Boundary_SEG(:) );  
    % average perpendicular distance from SEG to GT  
    apd = sum(min_S2G(:)) / length(min_S2G(:));  
end  