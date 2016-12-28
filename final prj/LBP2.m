xTrain=[Train_All_Data_SageLBP(:,1:900) Train_All_Data_SageLBP(:,1001:1900) ];
tTrain=[Train_All_Label_SageLBP(:,1:900) Train_All_Label_SageLBP(:,1001:1900) ];
xvali=[Train_All_Data_SageLBP(:,901:1000) Train_All_Data_SageLBP(:,1901:2000)  ];
tvali=[Train_All_Label_SageLBP(:,901:1000) Train_All_Label_SageLBP(:,1901:2000)];
xTest=[ Test_All_Data_DigiLBP];
tTest=[Test_All_Label_DigiLBP];

rng('default');
hiddenSize1 =370;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',2, ...
    'SparsityProportion',0.4, ...
    'ScaleData', false);


feat1 = encode(autoenc1,xTrain);
hiddenSize2 =150;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',150, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',2, ...
    'SparsityProportion',0.4, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,tTrain,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);
deepnet = train(deepnet,xTrain,tTrain);
y1 = deepnet(xTrain);
ezroc3_(y1,tTrain,2,'',1);
y2 = deepnet(xvali);
ezroc3_(y2,tvali,2,'',1);
y = deepnet(xTest);
ezroc3_(y,tTest,2,'',1);

