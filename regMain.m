% Regression Tree Main Scripts
function regMain(dataSet, regPurging, algorithm, kfold, do_draw, do_save_tree, do_cv)

% Set Parameters
tolS = regPurging.tolS;
tolN = regPurging.tolN;
algori = algorithm;

% Build Reg Tree: trainSet:80%, testSet:20%
fprintf('======Build %s Reg Tree: trainSet:80%%, testSet:20%%======\n',algori);
feature_used = [];
[m,n] = size(dataSet);
divideLine = floor(0.8 * m);
trainSet = dataSet(1:divideLine,:);
testSet = dataSet(divideLine+1:m,:);
tree = createTree(trainSet, tolS, tolN, feature_used, algori);

% Draw the Reg Tree
if strcmp(do_draw,'Y')
    fprintf('======Draw the Reg Tree======\n');
    DrawDecisionTree(tree);
end

% Show the RMSE
fprintf('======calculate the RMSE of the Reg Tree======\n');
trainedTree = tree;
% RMSE on TrainSet
predictedTrainSet = predictTree( trainedTree,trainSet(:,1:(n-1)) );
realSet = trainSet(:,n);
rmseValueTrain = calRMSE( realSet,predictedTrainSet' );
fprintf('RMSE on TrainDataSet %f\n', rmseValueTrain);

% RMSE on testSet
predictedTestSet = predictTree( trainedTree,testSet(:,1:(n-1)) );
realSet = testSet(:,n);
rmseValueTest = calRMSE( realSet,predictedTestSet' );
fprintf('RMSE on TestDataSet %f\n', rmseValueTest);

% Save the Reg Tree to a file
if strcmp(do_save_tree,'Y')
fprintf('======Save the Reg Tree to RegTree.mat======\n');
save('regTree.mat', 'tree');
end

% Do the 10-fold Cross validation
if strcmp(do_cv,'Y')

fprintf('======10-fold Cross validation Start======\n');
[testIndex, trainIndex] = kCrossV( dataSet, kfold );

rmseValueTrain = zeros(1,kfold);
rmseValueTest = zeros(1,kfold);

for i = 1:kfold
    feature_used = [];
    trainSet = dataSet(trainIndex{1,i},:);
    tree = createTree(trainSet, tolS, tolN, feature_used, algori);
    trainedTree = tree;
    
    fprintf('==Cross Validation: %d\n', i);
    
    % RMSE on TrainSet
    predictedTrainSet = predictTree( trainedTree,trainSet(:,1:(n-1)) );
    realSet = trainSet(:,n);
    rmseValueTrain(i) = calRMSE( realSet,predictedTrainSet' );
    fprintf('RMSE on TrainDataSet %f\n', rmseValueTrain(i));
    
    % RMSE on testSet
    testSet = dataSet(testIndex{1,i},:);
    predictedTestSet = predictTree( trainedTree,testSet(:,1:(n-1)) );
    realSet = testSet(:,n);
    rmseValueTest(i) = calRMSE( realSet,predictedTestSet' );
    fprintf('RMSE on TestDataSet %f\n', rmseValueTest(i));
end

% Calculate the mean RMSE value from cross validation 
finalRMSETrain = mean(rmseValueTrain);
finalRMSETest = mean(rmseValueTest);
fprintf('======Mean RMSE======\n');
fprintf('Mean RMSE on TrainSet %f\n', finalRMSETrain);
fprintf('Mean RMSE on TestSet %f\n', finalRMSETest);

end

fprintf('======Mission Complete======\n');
end