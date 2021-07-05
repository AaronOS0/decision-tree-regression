% Description: Calculate the RMSE  between the predicted dataSet and the real dataSet
% Args:
%      trainedTree: The tree was trained by train data
%      testSet: The dataSet to test the trainedTree
% Return:
%      rmseValue: The RMSE value

function [rmseValue] = calRMSE( realSet,predictedSet )
    
    [m,~] = size(realSet);
    rmseValue = sqrt(sum((realSet - predictedSet).^2 / m));

end