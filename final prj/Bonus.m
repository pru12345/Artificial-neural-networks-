Data = [Train_All_Data_DigiLBP ;Train_All_Data_DigiBGP*10^4 ];
xTrain=Data(:,1:1900);
xVali=Data(:,1901:2004);
Train_label=[Train_All_Label_DigiLBP ;Train_All_Label_DigiBGP ];
tTrain=Train_label(:,1:1900);
tVali=Train_label(:,1901:2004);
xTest=[Test_All_Data_DigiLBP;Test_All_Data_DigiBGP*10^4  ];
tTest=[Test_All_Label_DigiLBP ;Test_All_Label_DigiBGP ];

rng('default');
hiddenSize1 =350;

autoenc1 = trainAutoencoder(xTrain,hiddenSize1, ...
    'MaxEpochs',600, ...
    'L2WeightRegularization',0.005, ...
    'SparsityRegularization',2, ...
    'SparsityProportion',0.06, ...
    'ScaleData', false);


feat1 = encode(autoenc1,xTrain);
hiddenSize2 =75;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.05, ...
    'SparsityRegularization',1, ...
    'SparsityProportion',0.05, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);


softnet = trainSoftmaxLayer(feat2,tTrain,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);
deepnet = train(deepnet,xTrain,tTrain);
y1 = deepnet(xTrain);
ezroc3_(y1,tTrain,2,'',1);
y = deepnet(xTest);
ezroc3_(y,tTest,2,'',1);
