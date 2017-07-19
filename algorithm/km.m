
clc;
clear;
close all;
%% 读取数据
% AA=load('F:\matlabwork\cluster\dateset\flame.txt');K=2;
% AA=load('F:\matlabwork\cluster\dateset\Aggregation.txt');K=7;
AA=load('F:\matlabwork\cluster\dateset\pathbased.txt');K=3;
% AA=load('F:\matlabwork\cluster\dateset\spiral.txt');K=3;
% AA=load('F:\matlabwork\cluster\dateset\s2.txt');K=4;

%% 数据列归一化 
AA1=normalization(AA(:,[1,2]));
A=[AA1,AA(:,3)];
%no label
% LAB=ones(length(AA(:,1)),1);
% A=[AA1,LAB];

%聚类
%% 显示原始结果 
%数据格式为三列，前两列是二维数据，最后一列是类别  x,y,c  
%最多显示7中类别的聚类
ShowClusterA(A,'origin spiral')

%% 显示聚类结果
%kmeans聚类
% [cc,Dsum2,z2] = kmeans(A(:,[1,2]),K)
% B=[A(:,[1,2]),cc];
% ShowClusterA(B,'kmean spiral')
% 
% %FCM聚类
% [centers,U] = fcm(A(:,[1,2]),K);
% maxU = max(U);
% C1=zeros(1,length(maxU));
% for i=1:K
%     index1 = find(U(i,:) == maxU);
%     C1(index1)=i;
% end
% C=[A(:,[1,2]),C1'];
% ShowClusterA(C,'FCM spiral')
% 
% %DBSCAN聚类，选择epsilon和MinPts花了老半天的功夫
% %归一化后，对flame使用epsilon=0.2;具有很好的效果
% epsilon=0.2;
% MinPts=10;
% IDX=DBSCAN(A(:,[1,2]),epsilon,MinPts);
% D=[A(:,[1,2]),IDX];
% ShowClusterA(D,'DBSCAN spiral')
% 
% %谱聚类 SpectralClustering
% 
% W=pdist2(A(:,[1,2]),A(:,[1,2]),'minkowski',2);
% [E1, L, U] = SpectralClustering(W, K, 3);
% E=[A(:,[1,2]),E1];
% ShowClusterA(E,'SpectralClustering spiral')
% 
% %AP聚类
% pref = median(median(W));
% [idx,~,~,~]=apcluster(W,pref);
% ptsIdx=unique(idx);
% %转换为类别
% G1=zeros(length(idx),1);
% for i=1:length(ptsIdx)
%     G1(find(idx==ptsIdx(i)),:)=i;
% end
% G=[A(:,[1,2]),G1];
% ShowClusterA(G,'APClustering spiral')

%DBC密度峰聚类
ret=DPC(A(:,[1,2]),K);

F=[A(:,[1,2]),ret{2}'];
ShowClusterA(F,'DBC Clustering ');
cc=A(ret{1},[1,2]);
scatter(cc(:,1),cc(:,2),'filled','d','r');
%% 指标评判
%有label和没有label的

%% 指标比较