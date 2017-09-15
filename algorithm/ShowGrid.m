
%显示网格线并画点
clc;
clear;
close all;
L=6;
[X,Y] = meshgrid(1:L,1:L);
% X=1:L;
% Y=X;
figure
plot(X,'k');
hold on
plot(X,Y,'k');
N=50;
x=rand(1,N)*(L-1)+1;
y=rand(1,N)*(L-1)+1;
mm=length(x);
for i=1:mm
    if x(i)<4 && x(i)>3 && y(i)>4 && y(i)<5
        scatter(x(i),y(i),'o','MarkerFaceColor',[0,0,0],'MarkerEdgeColor',[0,0,0])               
    else
        scatter(x(i),y(i),'*','MarkerFaceColor',[0,0,0],'MarkerEdgeColor',[0,0,0])
    end
    hold on
end
for i=1:L-1
    for j=1:L-1
        num=(i-1)*5+j;
        text(i+0.5,j+0.5,num2str(num),'FontSize',10);
        hold on
    end
end
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
% title('二维变量空间网格化','FontSize',12);
% grid on