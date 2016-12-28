function O = call_tdnnSI(data_training,data_validation) 

target_cir=([ones(1,900),-1*ones(1,2700)]);
target_tri=([-1*ones(1,900),ones(1,900),-1*ones(1,1800)]);
target_right=([-1*ones(1,1800),ones(1,900),-1*ones(1,900)]);
target_down=([-1*ones(1,2700),ones(1,900)]);

target_matrix=([target_cir ;target_tri;target_right;target_down]);
target_Matrix=num2cell([ target_matrix target_matrix target_matrix target_matrix target_matrix],1);
n=16;
h=10;
net = timedelaynet(1:n,h);
net.trainFcn='trainbr';
net.trainParam.epochs=100;
net.layers{2}.transferFcn='tansig';
[Xsc,Xic,Aic,Tsc] = preparets(net,data_training,target_Matrix);
net = train(net,Xsc,Tsc,Xic,Aic);
OUT=cell2mat(sim(net,data_validation));

h11=[mean(OUT(1,1:900-n)),mean(OUT(1,900-n:1800-n)),mean(OUT(1,1800-n:2700-n)),mean(OUT(1,2700-n:3600-n))];
    h12=[mean(OUT(2,1:900-n)),mean(OUT(2,900-n:1800-n)),mean(OUT(2,1800-n:2700-n)),mean(OUT(2,2700-n:3600-n))];
    h13=[mean(OUT(3,1:900-n)),mean(OUT(3,900-n:1800-n)),mean(OUT(3,1800-n:2700-n)),mean(OUT(3,2700-n:3600-n))];
    h14=[mean(OUT(4,1:900-n)),mean(OUT(4,900-n:1800-n)),mean(OUT(4,1800-n:2700-n)),mean(OUT(4,2700-n:3600-n))];
    O=[h11;h12;h13;h14];
end