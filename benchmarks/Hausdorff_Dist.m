function hd = Hausdorff_Dist(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % erode element  
    s = cat(3, [0 0 0 ; 0 1 0 ; 0 0 0], [0 1 0 ; 1 1 1 ; 0 1 0], [0 0 0 ; 0 1 0 ; 0 0 0]);  
    % generate boundary  
    Boundary_SEG = logical(SEG) & ~imerode(logical(SEG), s);  
    Boundary_GT = logical(GT) & ~imerode(logical(GT), s);  
    % distance to nearest boundary point  
    Dist_SEG = bwdist(Boundary_SEG, 'euclidean');  
    Dist_GT = bwdist(Boundary_GT, 'euclidean');  
    % distance to another boundary  
    min_S2G = sort(Dist_GT( Boundary_SEG(:) ), 'ascend');  
    min_G2S = sort(Dist_SEG( Boundary_GT(:) ), 'ascend');  
    % hausdorff distance  
    hd = max(min_S2G(end), min_G2S(end));  
end  