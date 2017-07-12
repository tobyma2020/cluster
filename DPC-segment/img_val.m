function [ img_val ] = img_val( img_rgb )
%IMG_VAL 计算高斯过滤器创建金字塔，在LAB空间下，共6个向量，
%   此处显示详细说明


%转换到LAB空间
% stdf = makecform('srgb2lab');
% img_lab = applycform(img_rgb,stdf);
% img = uint8(img_lab);
% img= img_rgb;%直接使用RGB效果不好
% img=RGB2Lab(img_rgb);
% [row_img,col_img,n]=size(img);
I = im2double(img_rgb);
[x,y] = meshgrid(1:size(I,2),1:size(I,1));            % Spatial Features
L = [y(:)/max(y(:)),x(:)/max(x(:))];
%Pyramidgu 高斯过滤器创建金字塔
img_val_0=lab_vec(img_rgb,0,0);
img_val_5=lab_vec(img_rgb,5,2);
img_val_7=lab_vec(img_rgb,7,2);%设置2的效果比0.625效果好，这是为什么？？？？
%是不是应该加入位置信息，比较近的聚类权重更高？？？？？
img_val=[img_val_0 ,img_val_5,img_val_7];

end
function [ img_val ] = hsv_vec( img_rgb,hsize, sigma )
% 高斯过滤器创建金字塔，使用HSV作为特征向量，效果比较好？？？适合处理阴影
%这边的值可以取多少？模板大小3,5,7;标准差为:2,0.5,0.625?都有什么不一样。
%如果是使用系统vision.Pyramid函数呢，对应的参数又是多少？
%转换到hsv空间
img = rgb2hsv(img_rgb);
if(hsize>0)
    ker5=fspecial('gaussian',hsize,sigma);%大小为5的高斯核
    % ker7=fspecial('gaussian',7,2);
    img5 = imfilter(img,ker5);
else
    img5 = img;
end
%HSV
L_img5=img5(:,:,1);
A_img5=img5(:,:,2);
B_img5=img5(:,:,3);
%拼接图像金字塔构造的特征向量，生成符合要求的数据矩阵
%矩阵的每一行包含6个值
L_img5_ind=L_img5(:);
A_img5_ind=A_img5(:);%二维矩阵变成一维向量
B_img5_ind=B_img5(:);

%L_img5_ind,
img_val=[L_img5_ind,A_img5_ind ,B_img5_ind];
end

function [ img_val ] = lab_vec( img_rgb,hsize, sigma )
% 高斯过滤器创建金字塔，得到lab空间下的特征，适合处理有背景的
%这边的值可以取多少？模板大小3,5,7;标准差为:2,0.5,0.625?都有什么不一样。
%如果是使用系统vision.Pyramid函数呢，对应的参数又是多少？

img=rgb2lab(img_rgb);
if(hsize>0)
    ker5=fspecial('gaussian',hsize,sigma);%大小为5的高斯核
    % ker7=fspecial('gaussian',7,2);
    img5 = imfilter(img,ker5);
else
    img5 = img;
end
%分离出LAB只取AB进行处理
L_img5=img5(:,:,1);
A_img5=img5(:,:,2);
B_img5=img5(:,:,3);
%拼接图像金字塔构造的特征向量，生成符合要求的数据矩阵
%矩阵的每一行包含6个值
L_img5_ind=L_img5(:);
A_img5_ind=A_img5(:);%二维矩阵变成一维向量
B_img5_ind=B_img5(:);

%L_img5_ind,
img_val=[L_img5_ind,A_img5_ind ,B_img5_ind];
end



