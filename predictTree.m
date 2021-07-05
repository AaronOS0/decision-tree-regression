% Description: Use the trained tree to predict data on testData 
% Args:
%      trainedTree: The tree was trained by train data
%      testSet: The dataSet to test the trainedTree
% Return:
%      predictedSet: The predicted dataSet


function [predictedSet] = predictTree( trainedTree,testSet )

    [m,~] = size(testSet);

    if isempty(trainedTree.kids)
        predictedSet = trainedTree.class;
        return
    end

    for i = 1:m
        sample = testSet(i,:);
        if sample(trainedTree.attribute) > trainedTree.threshold
              predictedSet(i) = predictTree( trainedTree.kids{1,1},sample );
        else
              predictedSet(i) = predictTree( trainedTree.kids{1,2},sample );
        end 
    end
end