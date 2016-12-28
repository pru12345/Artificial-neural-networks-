U2=importdata('Person2.xls')
p2c1=num2cell(U2.data.Circle(:,[1 3]),2);p2c2=num2cell(U2.data.Circle(:,[5 7]),2);p2c3=num2cell(U2.data.Circle(:,[9 11]),2);
p2d1=num2cell(U2.data.Down(:,[1 3]),2);p2d2=num2cell(U2.data.Down(:,[5 7]),2);p2d3=num2cell(U2.data.Down(:,[9 11]),2);
p2r1=num2cell(U2.data.Right(:,[1 3]),2);p2r2=num2cell(U2.data.Right(:,[5 7]),2);p2r3=num2cell(U2.data.Right(:,[9 11]),2);
p2t1=num2cell(U2.data.Triangle(:,[1 3]),2);p2t2=num2cell(U2.data.Triangle(:,[5 7]),2);p2t3=num2cell(U2.data.Triangle(:,[9 11]),2);


C = horzcat( (-1*ones(300,1)) ,  ones(300,3));
fold1_target=num2cell( -1*vertcat(C , circshift(C,[1,1]), circshift(C,[1,2]), circshift(C,[1,3])),);
fold1_data=(vertcat( p2c1, p2d1, p2r1, p2t1 ));

%net

net = timedelaynet(1:30,10);
[Xs,Xi,Ai,Ts] = preparets(net,fold1_data',fold1_target');
net.performFcn='msereg';
[net,tr] = train(net,Xsc,Tsc,Xic,Aic);