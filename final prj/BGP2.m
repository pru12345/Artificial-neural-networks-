xTrain=[Train_All_Data_SageBGP(:,1:900) Train_All_Data_SageBGP(:,1001:1900) ].*10^4;
tTrain=[Train_All_Label_SageBGP(:,1:900) Train_All_Label_SageBGP(:,1001:1900) ];
xvali=[Train_All_Data_SageBGP(:,901:1000) ].*10^4;
tvali=[Train_All_Label_SageBGP(:,901:1000)];
xTest=[Test_All_Data_DigiBGP ].*10^4;
tTest=[Test_All_Label_DigiBGP ];

rng('default');
hiddenSize1 =500;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1, ...
    'MaxEpochs',1000, ...
    'L2WeightRegularization',0.2, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.02, ...
    'ScaleData', false);


feat1 = encode(autoenc1,xTrain);
hiddenSize2 =150;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.2, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.05, ...
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
