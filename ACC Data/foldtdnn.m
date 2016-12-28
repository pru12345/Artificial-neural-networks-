function H = foldtdnn(data_train,dval)
%net paramps
tc=([ones(1,300),zeros(1,900)]);
tt=([zeros(1,300),ones(1,300),zeros(1,600)]);
tr=([zeros(1,600),ones(1,300),zeros(1,300)]);
td=([zeros(1,900),ones(1,300)]);
data_target=[tc;tt;tr;td];
data_target=num2cell([data_target data_target],1);
net1 = timedelaynet(1:20,10);
net1.trainFcn='trainbr';
net1.trainParam.epochs=100;
net1.layers{2}.transferFcn='tansig';
%net
[Xsc,Xic,Aic,Tsc] = preparets(net1,data_train,data_target);
[net1,tr] = train(net1,Xsc,Tsc,Xic,Aic);
%data validation 



Yc=sim(net1,dval);
Yc=cell2mat(Yc);
n=20;
   h11=[mean(Yc(1,1:300-n)),mean(Yc(1,300-n:600-n)),mean(Yc(1,600-n:900-n)),mean(Yc(1,900-n:1200-n))];
    h12=[mean(Yc(2,1:300-n)),mean(Yc(2,300-n:600-n)),mean(Yc(2,600-n:900-n)),mean(Yc(2,900-n:1200-n))];
    h13=[mean(Yc(3,1:300-n)),mean(Yc(3,300-n:600-n)),mean(Yc(3,600-n:900-n)),mean(Yc(3,900-n:1200-n))];
    h14=[mean(Yc(4,1:300-n)),mean(Yc(4,300-n:600-n)),mean(Yc(4,600-n:900-n)),mean(Yc(4,900-n:1200-n))];
    H=[h11;h12;h13;h14];
end