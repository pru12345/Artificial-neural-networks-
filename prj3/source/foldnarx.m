function H = foldnarx(d,dval)

tc=([ones(1,300),zeros(1,900)]);
tt=([zeros(1,300),ones(1,300),zeros(1,600)]);
tr=([zeros(1,600),ones(1,300),zeros(1,300)]);
td=([zeros(1,900),ones(1,300)]);
data_target1=([tc;tt;tr;td]);
data_val_target=num2cell(data_target1,1)
data_target=num2cell([data_target1 data_target1],1);
%net paramps
net1 = narxnet(0:6,1:4,3);
net1.trainFcn='trainbr';
net1.trainParam.epochs=100;
net1.layers{2}.transferFcn='tansig';
net1=openloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,d,{},data_target);
net1 = train(net1,Xsc,Tsc,Xic,Aic);
net1=closeloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,dval,{},data_val_target);
net1 = train(net1,Xsc,Tsc,Xic,Aic);
Yc=cell2mat(sim(net1,Xsc,Xic,Aic,Tsc));
n=6;
   h11=[mean(Yc(1,1:300-n)),mean(Yc(1,300-n:600-n)),mean(Yc(1,600-n:900-n)),mean(Yc(1,900-n:1200-n))];
    h12=[mean(Yc(2,1:300-n)),mean(Yc(2,300-n:600-n)),mean(Yc(2,600-n:900-n)),mean(Yc(2,900-n:1200-n))];
    h13=[mean(Yc(3,1:300-n)),mean(Yc(3,300-n:600-n)),mean(Yc(3,600-n:900-n)),mean(Yc(3,900-n:1200-n))];
    h14=[mean(Yc(4,1:300-n)),mean(Yc(4,300-n:600-n)),mean(Yc(4,600-n:900-n)),mean(Yc(4,900-n:1200-n))];
    H=[h11;h12;h13;h14];
end