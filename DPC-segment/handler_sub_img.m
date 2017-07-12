function [ img_after ] = handler_sub_img( img_rgb,cell_mat )
%根据聚类结果对原小图进行处理，原来应该是在CFSFDP_IMG中处理的功能
% 每次在三个类中查找非0的第一个元素，就是要查找的最大聚类
% 如果没有经过处理,则都是第一个最大的
%     img_rgb=uint8(cell_imgs{5,5});
%     cell_mat=cell_imgs_mat{5,5};
%% 根据重新聚类的结果进行计算
    center_mat=[];
    for i=1:length(cell_mat{1})
    %找到所有为-1的
        if(cell_mat{1}(i)==-1)
            center_mat=[center_mat,find(cell_mat{2}==i)];        
        end
    end

    %% 直接使用第一最大的
%     center_mat=find(cell_mat{2}~=3);
    
    
    img_after=repmat(img_rgb,1);
    [row_img,col_img,~]=size(img_rgb);
    ss=[row_img,col_img];
    if(length(center_mat)>0)
        [X,Y]=ind2sub(ss,center_mat);
        for i=1:length(X)
            img_after(X(i),Y(i),:)=255;
    %         img_after(X(i),Y(i),2)=255;
    %         img_after(X(i),Y(i),3)=255; 
        end
    end
%     imshow(img_after);

end

