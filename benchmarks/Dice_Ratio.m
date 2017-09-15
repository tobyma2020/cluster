function dr = Dice_Ratio(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % dice ratio  
    dr = 2*double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:))) + sum(uint8(GT(:))));  
end  