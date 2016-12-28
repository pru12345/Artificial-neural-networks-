function H = int_tdnn(data_train,dval)
%net paramps
tc=([ones(1,900),zeros(1,2700)]);
tt=([zeros(1,900),ones(1,900),zeros(1,1800)]);
tr=([zeros(1,1800),ones(1,900),zeros(1,900)]);
td=([zeros(1,2700),ones(1,900)]);
data_target=[tc;tt;tr;td];
data_target=num2cell([data_target data_target data_target data_target data_target],1);

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
   h11=[mean(Yc(1,1:900-n)),mean(Yc(1,901-n:1800-n)),mean(Yc(1,1801-n:2700-n)),mean(Yc(1,2701-n:3600-n))];
    h12=[mean(Yc(2,1:900-n)),mean(Yc(2,901-n:600-n)),mean(Yc(2,1801-n:2700-n)),mean(Yc(2,2701-n:3600-n))];
    h13=[mean(Yc(3,1:900-n)),mean(Yc(3,901-n:600-n)),mean(Yc(3,1801-n:2700-n)),mean(Yc(3,2701-n:3600-n))];
    h14=[mean(Yc(4,1:900-n)),mean(Yc(4,901-n:600-n)),mean(Yc(4,1801-n:2700-n)),mean(Yc(4,2701-n:3600-n))];
    
    H=[h11;h12;h13;h14];
end