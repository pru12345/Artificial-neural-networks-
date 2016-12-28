function H = int_narx(d,dval)
%net paramps
tc=([ones(1,300),zeros(1,900)]);
tt=([zeros(1,300),ones(1,300),zeros(1,600)]);
tr=([zeros(1,600),ones(1,300),zeros(1,300)]);
td=([zeros(1,900),ones(1,300)]);
data_target=[tc;tt;tr;td];

data_target=([data_target data_target data_target ]);
k=num2cell(data_target,1);
data_target=num2cell([data_target data_target data_target data_target data_target ],1);
net1 = narxnet(0:5,1:4,3);
net1.trainFcn='trainbr';
net1.trainParam.epochs=100;
net1.layers{2}.transferFcn='tansig';
net1=openloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,d,{},data_target);
net1 = train(net1,Xsc,Tsc,Xic,Aic);
net1=closeloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,dval,{},k);
net1 = train(net1,Xsc,Tsc,Xic,Aic);
Yc=cell2mat(sim(net1,Xsc,Xic,Aic,Tsc));
%data validation 

n=5;
   h11=[mean(Yc(1,1:900-n)),mean(Yc(1,901-n:1800-n)),mean(Yc(1,1801-n:2700-n)),mean(Yc(1,2701-n:3600-n))];
    h12=[mean(Yc(2,1:900-n)),mean(Yc(2,901-n:600-n)),mean(Yc(2,1801-n:2700-n)),mean(Yc(2,2701-n:3600-n))];
    h13=[mean(Yc(3,1:900-n)),mean(Yc(3,901-n:600-n)),mean(Yc(3,1801-n:2700-n)),mean(Yc(3,2701-n:3600-n))];
    h14=[mean(Yc(4,1:900-n)),mean(Yc(4,901-n:600-n)),mean(Yc(4,1801-n:2700-n)),mean(Yc(4,2701-n:3600-n))];
    
    H=[h11;h12;h13;h14];
end