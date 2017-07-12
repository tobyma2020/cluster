%使用SLIC分块，每一块的求HOG特征，作为每一块的新向量，使用新向量进行DPC聚类
%使用HOG特征区分度太高，原木一样的都认为是不一样的：(

clear all  
close all  
clc
%% 读取图片
filename='1';
A = imread(sprintf('images/%s.jpg',filename));
[row,col,h]=size(A);

%% 使用superpixels分块
[L,N] = superpixels(A,5000);
figure
BW = boundarymask(L);
imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',100)
idx = label2idx(L);
%% 对每一块求最大长度，用来构建方块，以便求特征
maxRow=0;
maxCol=0;
for i = 1:N
    [X,Y]=ind2sub([row,col],idx{i});
    minX=min(X);
    maxX=max(X);
    if(maxX-minX+1>maxRow)
        maxRow=maxX-minX+1;
    end
    minY=min(Y);
    maxY=max(Y);
    if(maxY-minY+1>maxCol)
        maxCol=maxY-minY+1;
    end
end
maxRow=ceil(maxRow/3)*3;
maxCol=ceil(maxCol/3)*3;
%% 对每一块求原像素值
cell_imgs=cell(1,N);
for i = 1:N
    [X,Y]=ind2sub([row,col],idx{i});
    minX=min(X);
    maxX=max(X);
    minY=min(Y);
    maxY=max(Y);
    tempRect=zeros(maxRow,maxCol,3);
    for m=1:length(X)
        tempRect(X(m)-minX+1,Y(m)-minY+1,:)=A(X(m),Y(m),:);
    end
    cell_imgs{i}=tempRect;
end
%% 获取每一块的特征
cell_imgs_val=cell(1,N);
for i = 1:N
    tempRect=cell_imgs{i};
    [featureVector,hogVisualization] = extractHOGFeatures(tempRect,'CellSize',[2,2]);
    cell_imgs_val{i}=featureVector;
end 
%% 使用均值作为每一块的新特征
for i = 1:N
    new_imgs_val(i,:)=cell_imgs_val{i}(1,:);
end 
[coeff,score,latent] = pca(new_imgs_val);
new_img_after=DPC(new_imgs_val*coeff(:,1:1000),7);
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