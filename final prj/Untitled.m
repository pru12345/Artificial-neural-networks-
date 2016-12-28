xTrain=[Train_All_Data_DigiLBP Train_All_Data_SageLBP];
tTrain=[Train_All_Label_DigiLBP Train_All_Label_SageLBP];
xTest=[Test_All_Data_DigiLBP Test_All_Data_SageLBP];
tTest=[Test_All_Label_DigiLBP Test_All_Label_SageLBP];
rng('default');
hiddenSize1 =350;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1, ...
    'MaxEpochs',1000, ...
    'L2WeightRegularization',9, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.05, ...
    'ScaleData', false);


feat1 = encode(autoenc1,xTrain);
hiddenSize2 =150;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',2, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.05, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,tTrain,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);
deepnet = train(deepnet,xTrain,tTrain);
y1 = deepnet(xTrain);
ezroc3(y1,tTrain,2,'',1);
y = deepnet(xTest);
plotconfusion(tTest,y);
ezroc3(y,tTest,2,'',1);
