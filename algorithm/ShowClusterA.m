function  ShowClusterA( A,ctitle )
%SHOWCLUSTERA 此处显示有关此函数的摘要
%数据格式为三列，前两列是二维数据，最后一列是类别  x,y,c  
%最多显示7中类别的聚类

% colors=['r','g','b','y','m','c','k'];
N=length(unique(A(:,3)));
lineStyles = linspecer(N);
lineStyles=[[1,1,1];lineStyles];
figure;
for i=0:N
    ir = find(A(:,3)==i);         % 返回行索引  
    if(~isempty(ir))
    scatter(A(ir,1),A(ir,2),'MarkerFaceColor',lineStyles(i+1,:));
    end
    hold on
end
hold off
title(ctitle);

end

