
clc;
clear;
close all;
%% 读取数据
dd=load('mappedX.mat');
A=dd.mappedX;
A(:,3)=1;
% A=load('F:\matlabwork\cluster\dateset\pathbased.txt');

%% 数据归一化


%聚类
%% 显示原始结果 
%数据格式为三列，前两列是二维数据，最后一列是类别  x,y,c  
%最多显示7中类别的聚类
K=4;
ShowClusterA(A,'origin spiral');

%% 显示聚类结果
%kmeans聚类
[cc,Dsum2,z2] = kmeans(A(:,[1,2]),K);
B=[A(:,[1,2]),cc];
ShowClusterA(B,'kmean spiral');

%FCM聚类
[centers,U] = fcm(A(:,[1,2]),K);
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);
C1=zeros(1,length(maxU));
C1(index1)=1;
C1(index2)=2;
C=[A(:,[1,2]),C1'];
ShowClusterA(C,'FCM spiral');

%DBSCAN聚类，选择epsilon和MinPts花了老半天的功夫
epsilon=1.2;
MinPts=10;
IDX=DBSCAN(A(:,[1,2]),epsilon,MinPts);
D=[A(:,[1,2]),IDX];
ShowClusterA(D,'DBSCAN spiral');

%谱聚类 SpectralClustering

% W=pdist2(A(:,[1,2]),A(:,[1,2]),'minkowski',3);
% [E1, L, U] = SpectralClustering(W, 3, 3);
% E=[A(:,[1,2]),];
% ShowClusterA(E,'SpectralClustering spiral')

%密度峰聚类


ret=DPC(A(:,[1,2]),3);

F=[A(:,[1,2]),ret{2}'];
ShowClusterA(F,'DBC Clustering spiral')

%% 指标评判