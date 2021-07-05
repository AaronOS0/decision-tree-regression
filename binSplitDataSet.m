%% Split the dataSet by the best split index and value(threshold)

% Description: Use the best split index and value(threshold) to split the dataSet to left/right DataSet 
% Args:
%      dataSet: The dataset to split
%      feature: The index of the best split features
%      value: The value(threshold) of the best split features
% Return:
%      dataSetLeft: Left DataSet 
%      dataSetRight: Rright DataSet 


function [ dataSetLeft, dataSetRight ] = binSplitDataSet( dataSet, feature, value )
  
    [m,~] = size(dataSet);
    DataTemp = dataSet(:,feature)';% tansform to row model
    
    indexAll = 1:m;
    indexLeft = indexAll(DataTemp > value);
    indexRight = indexAll(DataTemp <= value);
    
    [~,nLeft] = size(indexLeft);
    [~,nRight] = size(indexRight);
    
    if nLeft>0 && nRight>0
        dataSetLeft = dataSet(indexLeft,:);
        dataSetRight = dataSet(indexRight,:);
    elseif nLeft == 0
            dataSetLeft = [];
            dataSetRight = dataSet;
    elseif nRight == 0
            dataSetRight = [];
            dataSetLeft = dataSet;
    end
end