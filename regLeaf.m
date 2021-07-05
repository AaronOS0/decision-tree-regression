% Description: Function to return the value of the leaf node
% Args:
%      dataSet: The dataset to return the predict value - leaf node
% Return:
%      leafValue: The the value of the leaf node

function [ leafValue ] = regLeaf( dataSet )
    m = size(dataSet);
    leafValue = mean(dataSet(:,m(2)));
end