%% Choose the best split index and value of all features  

% Description: Use the variance to choose the best split index and value
% Args:
%      dataSet: The dataset to train/build the tree
%      tolS: Tolerate(Min) decreased sum of variances
%      tolN: Tolerate(Min) number of nodes in dataSet
%      feature_used: store the index of features which have been used 
%      algori: only support 'CART' and 'ID3'
% Return:
%      Index: The index of the best split features
%      Value: The value(threshold) of the best split features

function [ Index, Value ] = chooseBestSplit( dataSet, tolS, tolN, feature_used,algori )

    % (m(1), m(2)) == (row, column)
    m = size(dataSet);

    if length(unique(dataSet(:,m(2)))) == 1% only one lable
        Index = 0;
        Value = regLeaf(dataSet(:,m(2)));
        return;
    end
    
    % Variance of original dataSet
    originalVar = varianceErr(dataSet);
    bestVar = inf;
    bestIndex = 0;
    bestValue = 0;
    
    % CART tree can use each features several times
    if strcmp(algori,'C4.5')
        feature_used = [];
    end
    
    allFeature = 1:(m(2)-1);
    unusedFeature = setdiff(allFeature, feature_used);
    [~,mf] = size(unusedFeature);
    % Find the best split index and value
    for j = 1:mf% traverse unusedFeature columns(features)
        uniqueValue = unique(dataSet(:,unusedFeature(j)));
        lenCharacter = length(uniqueValue);
        
        for i = 1:lenCharacter
            tempValue = uniqueValue(i,:);
            [matLeft,matRight] = binSplitDataSet(dataSet, unusedFeature(j) ,tempValue);
            mLeft = size(matLeft);
            mRight = size(matRight);
            if mLeft(1) < tolN || mRight(1) < tolN
                continue;
            end
            newVar = varianceErr(matLeft) + varianceErr(matRight);
            if newVar < bestVar
                bestVar = newVar;
                bestIndex = unusedFeature(j);
                bestValue = tempValue;
            end
        end
    end
    
    if (originalVar - bestVar) < tolS
        Index = 0;
        Value = regLeaf(dataSet(:,m(2)));
        return;
    end

    
    [matLeft, matRight] = binSplitDataSet(dataSet, bestIndex ,bestValue);

    mLeft = size(matLeft);
    mRight = size(matRight);
    if mLeft(1) < tolN || mRight(1) < tolN
        Index = 0;
        Value = regLeaf(dataSet(:,m(2)));
        return;
    end
    Index = bestIndex;
    Value = bestValue;
end