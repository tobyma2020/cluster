function recall = Recall(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % recall  
    recall = double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(GT(:))));  
end  