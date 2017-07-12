%读取图像,进行tsne降维
%把图像的每个像素点的特征,降维到二维
%在二维的坐标上查看该图像像素点的分布
%图像太大了就不行.90*100的就要2个多钟头
%后来又发现了LargeVis时间和空间效率更高，而且效果相差不大。建议使用
%该代码就没有什么用了


clear all  
close all  
%% 读入图片
filename='5-1-1';
img=imread(sprintf('%s.jpg',filename));
[row,col,h]=size(img);

imgs_val=img_val(uint8(img));

train_X =normalization(imgs_val);
labels=ones(col*row,1);
% Set parameters
no_dims = 3;
init_dims = 9;
perplexity = 30;
% Run t-SNE
mappedX = tsne(train_X, [], no_dims, init_dims, perplexity);
figure, scatter3(mappedX(:,1), mappedX(:,2), mappedX(:,3), 5, labels); title('Result of tsne');
save(sprintf('tsne%s.mat',filename),'mappedX');
