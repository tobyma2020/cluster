clear all  
close all  
clc
%% 读取图片
filename='6';
A = imread(sprintf('images/%s.jpg',filename));
[row,col,h]=size(A);
%% 对图片的每个像素点求特征
features=img_val(A);

%% 使用superpixels分块
[L,N] = superpixels(A,300);
idx = label2idx(L);
%% 获取每一块的特征
cell_imgs_val=cell(1,N);
for i = 1:N
    cell_imgs_val{i}=features(idx{i},:);
end 
%% 对每一块进行聚类，是不是可以测试下，每块聚类的效果
cell_imgs_mat=cell(1,N);
maxs=zeros(1,N);
for i = 1:N
%     redIdx = idx{labelVal};
    cell_imgs_mat{i}=DPC(cell_imgs_val{i},3);
end
%% 获取二次聚类中心候选点
 %有三个点,如果有不一定几个点的话，怎么存储数据？使用一个数组center_select，存储所有点的索引
ind=1;
 for i = 1:N
    icl=cell_imgs_mat{i}{1};
    for k=1:length(icl)
        temp_pos=icl(k);
        center_select(ind,:)=[i,k];%保存二维数据，第几块的第几个点为中心候选点
        %所有候选聚类中心点的数据即像素点特征值存放在new_img_val数组中
        new_img_val(ind,:)=cell_imgs_val{i}(temp_pos,:);
        ind=ind+1;
    end    
 end
%% 进行二次聚类

%二次聚类
new_img_after=DPC( new_img_val,4);

%查找二次聚类中点最多的聚类编号
max_num=tabulate(new_img_after{2});
max_num=sortrows(max_num,-2);
max_ind=max_num(1,1);
%设置二次聚类中非点最多的聚类编号为-1
% for k=1:length(new_img_after{1})
%     if(k~=max_ind)
%          new_img_after{1}(k)=-1;
%     end
% end    
%找出非主要的聚类中心点
new_img_center=[];

new_img_center=find(new_img_after{2}~=max_ind);
%         new_img_center=[new_img_center,find(new_img_after{2}==1)];
%         new_img_center=[new_img_center,find(new_img_after{2}==3)];
%         new_img_center=[new_img_center,find(new_img_after{2}==4)];
%          new_img_center=[new_img_center,find(new_img_after{2}==4)];
%         
%对所有非主要聚类中心点都设置为-1
% cell_imgs_mat2=repmat(cell_imgs_mat,1);
% for i=1:length(new_img_center)
%     tmp_ind=new_img_center(i);
%     x=center_select(tmp_ind,1);
%     k=center_select(tmp_ind,2);
%     cell_imgs_mat2{x}{1}(k)=-1;
% end

%设置图像中所有中心点为-1的类的所包含点为白色

A2=repmat(A,1);
for i=1:length(new_img_center)
    tmp_ind=new_img_center(i);
    x=center_select(tmp_ind,1);
    k=center_select(tmp_ind,2);
    [I,J]=ind2sub([row,col],idx{x}(find(cell_imgs_mat{x}{2}==k)));
    for m=1:length(I)
        A2(I(m),J(m),:)=255;
    end
end


imshow(A2);
