clc;
clear;
close all;
%% 读取数据
% AA=load('F:\matlabwork\cluster\dataset\shape\flame.txt');K=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\Aggregation.txt');K=7;
% AA=load('F:\matlabwork\cluster\dataset\shape\pathbased.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\spiral.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\seeds_dataset.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\D31.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\large2d\s2-lab.txt');K=4;
% AA=load('F:\matlabwork\cluster\dataset\large2d\birch1-lab.txt');K=14;
% AA=load('F:\matlabwork\cluster\dataset\large2d\magic04.lab.txt');K=14;
% AA=load('F:\matlabwork\cluster\dataset\large2d\Skin_NonSkin.txt');K=14;
AA=load('F:\matlabwork\cluster\dataset\shape\jain.txt');K=3;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\Compound.txt');K=3;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\R15.txt');K=3;KK=2;
%%
B=normalization(AA(:,1:end-1));
[rows,dim]=size(AA);
A=[B,AA(:,end)];
LAB=AA(:,end);
%% 核密度估计
% [f,xi] = ksdensity(AA(:,1:2));
% figure
% plot(xi,f);
% rho=zeros(rows,1);
% s=sum(f);
% for i=1:rows
%     x=AA(i,1:2);
%     f2= ksdensity(x,xi);
%     rho(i)=sum(f2)/s;
% end
% p = kde( rand(2,1000), .05, ones(1,1000) );
p = kde(B', 'rot' ); % Gaussian kernel, 2D % BW = .05 in dim 1, .03 in dim 2.
plot(p); % where T = 'G', 'E', or 'L'
figure;
mesh(hist(p));
% p1 = marginal(p,[1]);
% p2 = marginal(p,[2]);
%%小波
% x=[0.9, 0.95, 1, 1.1, 1.24, 1.3, 1.32, 2.9, 2.98, 2.99, 2.999, 3, 3.08, 3.1, 3.109, 3.2, 4, 4.5];
% [f,xi,bw] = ksdensity(x);
% figure
% plot(xi,f);
% sum(f)
% f2= ksdensity([14],xi);
% 
% sum(f2)/sum(f);