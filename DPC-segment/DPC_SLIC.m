%随机抽取64×64个点，使用密度聚类算法求的聚类中心，用于slic的聚类中心

%使用SLIC分块，每一块的向量均值，作为每一块的新向量，使用新向量进行DPC聚类
%除了树叶与原木区分不开，其它的效果都很好，是不是特征值需要重新选一个？
%测试了使用HOG特征，因为区分太开，都被删除了。

clear all  
close all  
clc
%% 读取图片
filename='1';
A = imread(sprintf('images/%s.jpg',filename));
[row,col,h]=size(A);
%% 对图片的每个像素点求特征
features=img_val(A);

%% 使用superpixels分块
[L,N] = superpixels(A,2000);
figure
BW = boundarymask(L);
imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',100)
idx = label2idx(L);
%% 获取每一块的特征
cell_imgs_val=cell(1,N);
for i = 1:N
    cell_imgs_val{i}=features(idx{i},:);
end 
%% 使用均值作为每一块的新特征
for i = 1:N
    new_imgs_val(i,:)=mean(features(idx{i},:));
end 

new_img_after=DPC(new_imgs_val,3);
%查找DPC聚类中点最多的聚类编号
max_num=tabulate(new_img_after{2});
max_num=sortrows(max_num,-2);
max_ind=max_num(1,1);

%找出非主要的聚类中心点
new_img_center=find(new_img_after{2}~=max_ind);

% 非聚类中心的块设置为白色
A2=repmat(A,1);
for i=1:length(new_img_center)
    x=new_img_center(i);   
    [I,J]=ind2sub([row,col],idx{x});
    for m=1:length(I)
        A2(I(m),J(m),:)=255;
    end
end
figure;imshow(A);
figure;imshow(A2);