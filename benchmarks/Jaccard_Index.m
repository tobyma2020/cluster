function jaccard = Jaccard_Index(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % jaccard index  
    jaccard = double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:) | GT(:))));  
end  