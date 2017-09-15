% AA=load('F:\matlabwork\cluster\dataset\shape\flame.txt');K=2;
% AA=load('F:\matlabwork\cluster\dataset\shape\Aggregation.txt');K=7;
% AA=load('F:\matlabwork\cluster\dataset\shape\pathbased.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\spiral.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\seeds_dataset.txt');K=3;
% AA=load('F:\matlabwork\cluster\dataset\shape\D31.txt');K=3;
B=normalization(AA(:,1:end-1));
[rows,dim]=size(AA);
A=[B,AA(:,end)];
LAB=AA(:,end);

% L=chol([1,-0.999;-0.999,1],'lower');L1=chol([1,0.999;0.999,1],'lower');
%   data=[(L1*randn(10^3,2)')';(L*randn(10^3,2)')'*2;rand(10^4,2)*5-2.5];
%   [pdf,X1,X2]=akde(data);
  [pdf,X1,X2]=akde(B);
  pdf=reshape(pdf,size(X1));
  contour(X1,X2,pdf,20)