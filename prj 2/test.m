load('P.mat')
load('T.mat')

[trainP,valP,testP,trainInd,valInd,testInd]=dividerand(P,0.6,0.2,0.2);	
[trainT,valT,testT]=divideind(T,trainInd,valInd,testInd);
GOAL=0.5;

mse1v = 1;
spread1 = 1.01;
 
while mse1v >= 0.5
net1 = newrbe(trainP,trainT,spread1); %x is training mse 
y1v = sim(net1,valP);
 mse1v = mse(y1v-valT) %valiation mse 
 spread1 = spread1+0.5
end

mse2v = 1;
spread2 = 1.01;
 
g=0.2;

while mse2v >= 0.5
net2 = newrb(trainP,trainT,g,spread2);%x is training mse 
y2v = sim(net2,valP);
 mse2v=mse(y2v-valT) %valiation mse 
 spread2=spread2+0.5
end

y1v= sim(net1,valP);
y1Tr= sim(net1,trainP);
y1T=sim(net1,testP);                 %simulation of train,test,validate 
y2v= sim(net2,valP);
y2Tr= sim(net2,trainP);
y2T=sim(net2,testP);


confusionmat_validate_net1=confusionmat(valT,trans(y1v));
confusionmat_train_net1=confusionmat(trainT,trans(y1Tr));
confusionmat_test_net1=confusionmat(testT,trans(y1T));
confusionmat_validate_net2=confusionmat(valT,trans(y2v));        %creates confusion matrices  
confusionmat_train_net2=confusionmat(trainT,trans(y2Tr));
confusionmat_test_net2=confusionmat(testT,trans(y2T));

figure
plotconfusion(trans(valT),trans(y1v),'validation confusion matrix net 1');
figure
plotconfusion(trans(trainT),trans(y1Tr),'train confusion matrix net 1');
figure
plotconfusion(trans(testT),trans(y1T),'test confusion matrix net 1');                      %plot confution in graph using plot confusion 
figure
plotconfusion(trans(valT),trans(y2v),'validation confusion matrix net 2');
figure
plotconfusion(trans(trainT),trans(y2Tr),'train confusion matrix net 2');
figure
plotconfusion(trans(testT),trans(y2T),'test confusion matrix net 2');

roc1= ezroc3(trans(y1v),trans(valT),2,'RoC Curve-Validation',1);
roc3= ezroc3(trans(y1Tr),trans(trainT),2,'RoC Curve-Training',1);
roc2= ezroc3(trans(y1T),trans(testT),2,'RoC Curve-Test',1);

roc1= ezroc3(trans(y2v),trans(valT),2,'RoC Curve-Validation',1);
roc3= ezroc3(trans(y2Tr),trans(trainT),2,'RoC Curve-Training',1);
roc2= ezroc3(trans(y2T),trans(testT),2,'RoC Curve-Test',1);

