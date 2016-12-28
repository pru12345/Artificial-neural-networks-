xTrain=[Train_All_Data_SageBSIF(:,1:900) Train_All_Data_SageBSIF(:,1001:1900) ].*10^4;
tTrain=[Train_All_Label_SageBSIF(:,1:900) Train_All_Label_SageBSIF(:,1001:1900) ];
xvali=[Train_All_Data_SageBSIF(:,901:1000) ].*10^4;
tvali=[Train_All_Label_SageBSIF(:,901:1000)];
xTest=[Test_All_Data_DigiBSIF].*10^4;
tTest=[Test_All_Label_DigiBSIF];



rng('default');
hiddenSize1 =750;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1, ...
    'MaxEpochs',1000, ...
    'L2WeightRegularization',0.5, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.03, ...
    'ScaleData', false);


feat1 = encode(autoenc1,xTrain);
hiddenSize2 =200;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.5, ...
    'SparsityRegularization',5, ...
    'SparsityProportion',0.05, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,tTrain,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);
deepnet = train(deepnet,xTrain,tTrain);
y = deepnet(xTest);
plotconfusion(tTest,y);
ezroc3_(y,tTest,2,'',1);
y1 = deepnet(xTrain);
ezroc3_(y1,tTrain,2,'',1);
y2 = deepnet(xvali);
ezroc3_(y2,tvali,2,'',1);

