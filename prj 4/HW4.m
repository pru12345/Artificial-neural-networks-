 k=1;
data_train=cell(1,240);
data_test=cell(1,160);
for ii=1:40
for jj=1:6
data_train{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(ii),'\',num2str(jj),'.pgm')));
 k = k + 1;
end
end


 k=1;
for ii=1:40
for jj=7:10
data_test{k}=im2double(imread(strcat('\\kc.umkc.edu\kc-users\home\p\ps5m6\Desktop\att_faces\s',num2str(ii),'\',num2str(jj),'.pgm')));
 k = k + 1;
end
end



x=[ones(1,6),zeros(1,234)];
for ii=1:40
    target_train(ii,:)=x;
    x=circshift(x,6,2);
end

y=[ones(1,4),zeros(1,156)];
for ii=1:40
    target_test(ii,:)=y;
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
for ii = 1:numel(data_test)
    xTest(:,ii) = data_test{ii}(:);
end


xTrain = zeros(inputSize,numel(data_train));
for ii = 1:numel(data_train)
    xTrain(:,ii) = data_train{ii}(:);
end
deepnet = train(deepnet,xTrain,target_train);

y1 = deepnet(xTrain);

mse1 = zeros(40,4,40);
i = 1;
for ii = 1:40
    for jj = 1:4
        Y = y(:,i);
        mse1(:,jj,ii) = Y;
        i = i+1;
    end
end

intraClassMSE = zeros(40,4);
for ii = 1:40
    for jj = 1:4
        intraMSE = zeros(1,3);
        i = 1;
        for m = 1:4
            if jj ~= m
                intraMSE(1,i) = mse(mse1(:,jj,ii),mse1(:,m,ii));
                i = i + 1;
            end
        end
        intraClassMSE(ii,jj) = sum(intraMSE);
    end
end

interClassMSE = zeros(40,4);
for ii = 1:40
    for jj = 1:4
        i = 1;
        interMSE = zeros(1,156);
        for m = 1:40
            if ii ~= m
                for ll = 1:4
                    interMSE(1,i) = mse(mse1(:,jj,ii),mse1(:,ll,m));
                    i = i + 1;
                end
            end
        end
        interClassMSE(ii,jj) = sum(interMSE);
    end
end

ratio = sum(interClassMSE(:))/sum(intraClassMSE(:));

H=ezroc3(y,target2,2,' ',1);

H = -[interMSE intraMSE];
Y = [zeros(1,156) ones(1,3)];
ezroc3(H,Y,2,' ',1);

plotconfusion(target_train,y);
y = deepnet(xTest);
plotconfusion(target_test,y);

H=ezroc3(y,target_test,2,' ',1);
