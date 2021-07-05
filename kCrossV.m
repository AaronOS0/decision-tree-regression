% Description: k-Fold Cross Validation 
% Args:
%      dataSet: The dataset to form the k-Fold Cross Validation
%      foldNum: k-Fold
% Return:
%      testIndex: The Index of all the test dataSet
%      trainIndex: The Index of all the train dataSet


function [testIndex, trainIndex] = kCrossV( dataSet,foldNum )

    [m,~] = size(dataSet);
    dataNum = floor(m/foldNum);
    idx = randperm(m);
    
    for i = 1:foldNum

        startIndex = dataNum * (i-1) + 1;
        endIndex = dataNum * i;
        testIndex{i} = idx(startIndex:endIndex);
        trainIndex{i} = setdiff(idx,testIndex{i},'stable');
    end
    
end