% Regression Tree Main Scripts
clear;
clc;

% Load data
dataSet = xlsread('plant.xlsx', 'Sheet1');

% Set Parameters
% algorithm can be 'C4.5' or 'ID3'; use 'ID3' as default
algorithm = 'C4.5';

% PrePurging
% tolS: Tolerate(Min) decreased sum of variances
% tolN: Tolerate(Min) number of nodes in dataSet
regPurging = struct('tolS', 1, 'tolN', 150);

% 'Y' or 'N'; default is 'N'
do_draw = 'Y';
do_save_tree = 'N'; %regTree.mat
do_cv = 'N'; %Cross Validation

% The number of Cross Validation
kfold = 10;

% The Entrance function
regMain(dataSet, regPurging, algorithm, kfold, do_draw, do_save_tree, do_cv);