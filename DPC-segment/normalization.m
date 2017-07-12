function [ B ] = normalization( A )
%NORMALIZATION 数据列的归一化
%   此处显示详细说明
    X=A';
    [Y,~]=mapminmax(X,0,1);%行归一化
    B=Y';
end

