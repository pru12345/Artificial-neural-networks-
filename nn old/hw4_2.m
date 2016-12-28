j1=1;i=1;
for i=1:40
k=1;


    for j=1:+6
data_train{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(i),'\',num2str(j),'.pgm')));
 k = k + 1;
    end


k=1;
    for j=7:10
data_test{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(i),'\',num2str(j),'.pgm')));
 k = k + 1;
    end
    
    

  
target_train=[ones(1,6);zeros(39,6)];

target_test=[ones(1,4);zeros(39,4)];

rng('default');
hiddenSize1 = 100;
autoenc1 = trainAutoencoder(data_train,hiddenSize1, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.04, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false);
feat1 = encode(autoenc1,data_train);

hiddenSize2 =100;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',200, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);
feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,target_train,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);

imageWidth = 92;
imageHeight = 112;
inputSize = imageWidth*imageHeight;




xTest = zeros(inputSize,numel(data_test));
for i = 1:numel(data_test)
    xTest(:,i) = data_test{i}(:);
end
y = deepnet(xTest);
plotconfusion(target_test,y);

xTrain = zeros(inputSize,numel(data_train));
for i = 1:numel(data_train)
    xTrain(:,i) = data_train{i}(:);
end
deepnet = train(deepnet,xTrain,target_train);

y = deepnet(xTest);
plotconfusion(target_test,y);

H=ezroc3(y,target_test,2,' ',1);



target_train=circshift(target_train,1,1);
target_shift=circshift(target_test,1,1);
    
end   
    
    
    
 

   
    
    
    
    
    
