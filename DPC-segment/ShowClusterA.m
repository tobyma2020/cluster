function  ShowClusterA( A,ctitle )
%SHOWCLUSTERA 此处显示有关此函数的摘要
%数据格式为三列，前两列是二维数据，最后一列是类别  x,y,c  
%最多显示7中类别的聚类

colors=['r','g','b','y','m','c','k'];
figure;
for i=1:7
    ir = find(A(:,3)==i);         % 返回行索引   
    scatter(A(ir,1),A(ir,2),colors(i));
    hold on
end
hold off
title(ctitle);

end

