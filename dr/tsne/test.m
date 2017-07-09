% Load data
A=importdata('F:\matlabwork\cluster\dateset\iris2.data');

% load ¡¯mnist_train.mat¡¯
% train_X=loadMNISTImages('F:\matlabwork\cluster\dateset\train-images.idx3-ubyte');
% train_labels=loadMNISTLabels('F:\matlabwork\cluster\dateset\train-labels.idx1-ubyte');
% train_X=train_X';
% ind = randperm(size(train_X, 1));
% train_X = train_X(ind(1:5000),:);
% train_labels = train_labels(ind(1:5000));
train_X = A(:,[1,2,3,4]);
train_labels = A(:,5);
% Set parameters
no_dims = 2;
init_dims = 4;
perplexity = 30;
% Run t?SNE
mappedX = tsne(train_X, [], no_dims, init_dims, perplexity);
% Plot results
figure
gscatter(mappedX(:,1), mappedX(:,2), train_labels,'br','xo');


%% ÏÔÊ¾²ÎÊı