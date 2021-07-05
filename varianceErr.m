% Description: Function to calculate the variance of each dataSet
% Args:
%      dataSet: The dataset to calculate the variance
% Return:
%      variances: The variance of the dataSet

function [ variances ] = varianceErr( dataSet )
    m = size(dataSet);
    dataVar = var(dataSet(:,m(2)));
    variances = dataVar * (m(1)-1);
end