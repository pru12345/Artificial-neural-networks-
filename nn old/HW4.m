 k=1;
data_train=cell(1,240);
data_test=cell(1,160);
for i=1:40
for j=1:6
data_train{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(i),'\',num2str(j),'.pgm')));
 k = k + 1;
end
end


 k=1;
for i=1:40
for j=7:10
data_test{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(i),'\',num2str(j),'.pgm')));
 k = k + 1;
end
end



x=[ones(1,6),zeros(1,234)];
for i=1:40
    target_train(i,:)=x;
    x=circshift(x,6,2);
end

y=[ones(1,4),zeros(1,156)];
for i=1:40
    target_test(i,:)=y;
    y=circshift(y,4,2);
end

rng('default');
hiddenSize1 = 100;
autoenc1 = trainAutoencoder(data_train,hiddenSize1, ...
    'MaxEpochs',50, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.3, ...
    'ScaleData', false);
feat1 = encode(autoenc1,data_train);

hiddenSize2 =50;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',50, ...
    'L2WeightRegularization',0.001, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);
feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,target_train,'MaxEpochs',400);

deepnet = stack(autoenc1,autoenc2,softnet);
view(deepnet)
imageWidth = 92;
imageHeight = 112;
inputSize = imageWidth*imageHeight;




xTest = zeros(inputSize,numel(data_test));
for i = 1:numel(data_test)
    xTest(:,i) = data_test{i}(:);
end


xTrain = zeros(inputSize,numel(data_train));
for i = 1:numel(data_train)
    xTrain(:,i) = data_train{i}(:);
end
deepnet = train(deepnet,xTrain,target_train);


y = deepnet(xTrain);
plotconfusion(target_train,y);
y = deepnet(xTest);
plotconfusion(target_test,y);

H=ezroc3(y,target_test,2,' ',1);
