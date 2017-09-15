%http://blog.csdn.net/yangyangyang20092010/article/details/51637073
% test all segmentation metric functions  
%图像分割评价标准
SEG = imread('0.png');  
GT = imread('1.png');  
  
% binarize  
SEG = im2bw(SEG, 0.1);  
GT = im2bw(GT, 0.1);  
  
dr = Dice_Ratio(SEG, GT)  
hd = Hausdorff_Dist(SEG, GT)  
jaccard = Jaccard_Index(SEG, GT)  
apd = Avg_PerpenDist(SEG, GT)  
confm_index = ConformityCoefficient(SEG, GT)  
precision = Precision(SEG, GT)  
recall = Recall(SEG, GT)  