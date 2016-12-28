
data=importdata('Person2.xls',' ',3);
c1=data.data.Circle(:,[1,3]);
t1=data.data.Triangle(:,[1,3]);
r1=data.data.Right(:,[1,3]);
d1=data.data.Down(:,[1,3]);
c1=num2cell(c1',1);
t1=num2cell(t1',1);
r1=num2cell(r1',1);
d1=num2cell(d1',1);
d=[c1,t1,r1,d1];
c2=data.data.Circle(:,[5,7]);
t2=data.data.Triangle(:,[5,7]);
r2=data.data.Right(:,[5,7]);
d2=data.data.Down(:,[5,7]);
c2=num2cell(c2',1);
t2=num2cell(t2',1);
r2=num2cell(r2',1);
d2=num2cell(d2',1);
dval=[c2,t2,r2,d2];

tc=([ones(1,300),zeros(1,900)]);
tt=([zeros(1,300),ones(1,300),zeros(1,600)]);
tr=([zeros(1,600),ones(1,300),zeros(1,300)]);
td=([zeros(1,900),ones(1,300)]);
data_target=[tc;tt;tr;td];
data_target=num2cell(data_target,1);

for i=1:5
    
net1 = narxnet(0:15,1:6,10);
net1.trainFcn='trainbr';
net1.trainParam.epochs=100;
net1.layers{2}.transferFcn='tansig';
net1=openloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,d,{},data_target);
net1 = train(net1,Xsc,Tsc,Xic,Aic);
net1=closeloop(net1);
[Xsc,Xic,Aic,Tsc] = preparets(net1,dval,{},data_target);
Yc=cell2mat(sim(net1,Xsc,Xic,Aic,Tsc));

n=15;
h11=[mean(Yc(1,1:300-n)),mean(Yc(1,301-n:600-n)),mean(Yc(1,601-n:900-n)),mean(Yc(1,901-n:1200-n))];
    h12=[mean(Yc(2,1:300-n)),mean(Yc(2,301-n:600-n)),mean(Yc(2,601-n:900-n)),mean(Yc(2,901-n:1200-n))];
    h13=[mean(Yc(3,1:300-n)),mean(Yc(3,301-n:600-n)),mean(Yc(3,601-n:900-n)),mean(Yc(3,901-n:1200-n))];
    h14=[mean(Yc(4,1:300-n)),mean(Yc(4,301-n:600-n)),mean(Yc(4,601-n:900-n)),mean(Yc(4,901-n:1200-n))];
   H(:,:,i)=[h11;h12;h13;h14];

end

ezroc3(H,[],2,' ',1)

