
clc;
clear;
close all;
%% 读取数据
% AA=load('F:\matlabwork\cluster\dataset\shape\flame.txt');K=2;
AA=load('F:\matlabwork\cluster\dataset\shape\Aggregation.txt');K=7;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\pathbased.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\spiral.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\jain.txt');K=3;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\Compound.txt');K=3;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\R15.txt');K=3;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\seeds_dataset.txt');K=3;KK=7;
% AA=load('F:\matlabwork\cluster\dataset\shape\D31.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\large2d\s2-lab.txt');K=4;KK=2;
% AA=load('F:\matlabwork\cluster\dataset\large2d\birch1-lab.txt');K=14;
% AA=load('F:\matlabwork\cluster\dataset\large2d\magic04.lab.txt');K=14;
% AA=load('F:\matlabwork\cluster\dataset\large2d\Skin_NonSkin.txt');K=14;
%% 数据列归一化 
B=normalization(AA(:,1:end-1));
[rows,dim]=size(AA);
A=[B,AA(:,end)];
LAB=AA(:,end);
%no label
% LAB=AA(:,3);
% LAB=ones(length(AA(:,1)),1);
% A=[AA1,LAB];
%%%
% A = csvread('F:\matlabwork\LS-DPC\KSC-FS_lab\magic04.csv'); K=2;
% AA1 = A(:,1:end-1);
% AA1 = normalization(AA1);
% LAB = A(:,end) + 2;
%聚类
%% 显示原始结果 
%数据格式为三列，前两列是二维数据，最后一列是类别  x,y,c  
%最多显示7中类别的聚类
% B=A(randi(160000,1,1000),:);
if( dim==3)
    ShowClusterA(A,'origin spiral')
end
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
% W=pdist2(A(:,[1,2]),A(:,[1,2]),'minkowski',2);
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
ret=DPC(B,K,KK);
% 
F=[B,ret.cl'];
if( dim==3)
ShowClusterA(F,'DBC Clustering ');
end
icl=ret.icl;
for i=1:length(icl)
    cl=icl(i);
    circle(B(cl,1),B(cl,2),ret.dc);
    hold on;
end
LB=ret.cl';
critcurr1 = evalclusters(B,LB,'DaviesBouldin');
ari1=adjrandindex(LAB,LB);
% p = kde(B', .05 ); % Gaussian kernel, 2D % BW = .05 in dim 1, .03 in dim 2.
% % plot(p); % where T = 'G', 'E', or 'L'
% figure;
% mesh(hist(p));
% figure;scatter(cc(:,1),cc(:,2),'filled','d','r');
% cc=A(ret{1},[1,2]);
% figure;scatter(cc(:,1),cc(:,2),'filled','d','r');
% data=load('datacells.mat');
% datacells=data.datacells;
% 
% %WaveCluster
% [G, clustergrid, counts, datacellindices, wdata, sigcells]= WaveCluster(B, [],256, '5%',2, 'bior2.2', 1);
% % % gscatter(AA(:,1), AA(:,2), WaveCluster(AA, [], 120, '10%', 2, 'bior2.2', 1))
% 
% for i=1:rows
%     LB(i,1)=clustergrid(datacellindices(i,1),datacellindices(i,2),1)+1;
% end
% if( dim==3)
%     ShowClusterA([B,LB],'WaveCluster Clustering ');
% end
% 
% critcurr2 = evalclusters(B,LB,'DaviesBouldin');
% ari2=adjrandindex(LAB,LB);
%% 指标评判
%有label和没有label的

%% 指标比较


