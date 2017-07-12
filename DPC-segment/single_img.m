%%  单个图片测试程序
clear all  
close all  
%% 读入图片
filename='5-1-1';
img=imread(sprintf('%s.jpg',filename));
[row,col,h]=size(img);


%% 读取数据
dd=load(sprintf('PCA%s.mat',filename));
A=dd.mappedX;
A =normalization(A);
A(:,length(A(1,:))+1)=1;

imgval=img_val(img);
%DBC密度峰聚类
% imgs_mat=DPC(A(:,[1,2]),3);
imgs_mat=DPC(imgval,3);

F=[A(:,[1,2]),imgs_mat{2}'];
figure, scatter3(A(:,1), A(:,2), A(:,3), 5, A(:,4)); title('Result of tsne');

% imgs_mat{1}(1)=-1;
 %查找看哪个点最多
max_num=tabulate(imgs_mat{2});
max_num=sortrows(max_num,-2);
max_ind=max_num(1,1);
% % imgs_mat{1}(max_ind)=-1;
for k=1:length(imgs_mat{1})
    if(k~=max_ind)
         imgs_mat{1}(k)=-1;
    end
end    

imgs_after=handler_sub_img(uint8(img),imgs_mat);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(imgs_after);