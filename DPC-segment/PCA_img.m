%读取图像,进行tsne降维
%把图像的每个像素点的特征,降维到二维
%在二维的坐标上查看该图像像素点的分布
%图像太大了就不行.90*100的就要2个多钟头
%


clear all  
close all  
%% 读入图片
filename='5-1-1';
img=imread(sprintf('%s.jpg',filename));
[row,col,h]=size(img);

imgs_val=img_val(uint8(img));

train_X =normalization(imgs_val);

labels=ones(col*row,1);
no_dims=3;
[mappedX, mapping] = compute_mapping(train_X, 'PCA', no_dims);
figure, scatter3(mappedX(:,1), mappedX(:,2), mappedX(:,3), 5, labels); title('Result of PCA');

save(sprintf('PCA%s.mat',filename),'mappedX');

