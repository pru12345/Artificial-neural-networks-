function [yt,ytest]=deepnet1(hiddenSize1,MAXEPOCH1,reg1,spareg1,spa1,hiddenSize2,MAXEPOCH2,reg2,spareg2,spa2)

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
autoenc1 = trainAutoencoder(data_train,hiddenSize1, ...
    'MaxEpochs',MAXEPOCH1, ...
    'L2WeightRegularization',reg1, ...
    'SparsityRegularization',spareg1, ...
    'SparsityProportion',spa1, ...
    'ScaleData', false);
feat1 = encode(autoenc1,data_train);

autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',MAXEPOCH2, ...
    'L2WeightRegularization',reg2, ...
    'SparsityRegularization',spareg2, ...
    'SparsityProportion',spa2, ...
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


yt= deepnet(xTrain);
ytest= deepnet(xTest);
end