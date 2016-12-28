data=importdata('Person2.xls',' ',3);
c1=num2cell(data.data.Circle(:,[1,3])',1);
t1=num2cell(data.data.Triangle(:,[1,3])',1);
r1=num2cell(data.data.Right(:,[1,3])',1);
d1=num2cell(data.data.Down(:,[1,3])',1);
d=[c1,t1,r1,d1];
c2=num2cell(data.data.Circle(:,[5,7])',1);
t2=num2cell(data.data.Triangle(:,[5,7])',1);
r2=num2cell(data.data.Right(:,[5,7])',1);
d2=num2cell(data.data.Down(:,[5,7])',1);
dval=[c2,t2,r2,d2];

tc=([ones(1,300),zeros(1,900)]);
tt=([zeros(1,300),ones(1,300),zeros(1,600)]);
tr=([zeros(1,600),ones(1,300),zeros(1,300)]);
td=([zeros(1,900),ones(1,300)]);
target_mat=[tc ;tt; tr ;td];
target=num2cell([tc ;tt; tr ;td],1);
%for Tap_delayline = 25:5:35
 %   for Hidden_layers=35:5:45
%net parameters 
net1 = timedelaynet(1:10,10);
net1.trainFcn='trainbr';
net1.performFcn='msereg' ;
net.performParam.ratio=1;
net1.trainParam.epochs=100;
net1.layers{2}.transferFcn='tansig';
%net 
[Xsc,Xic,Aic,Tsc] = preparets(net1,d,target);
[net1,tr] = train(net1,Xsc,Tsc,Xic,Aic);
Yc=sim(net1,dval);
Yc=round_07(cell2mat(Yc));
plotconfusion(target_mat,out);
ezroc3(Yc,target_mat,2,'RoC Curve-Validation',1)
%    end
% end
