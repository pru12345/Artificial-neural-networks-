%subject specific tdna 
data=importdata('Person1.xls',' ',3);

c1=num2cell(data.data.Circle(:,[1,3])',1);
t1=num2cell(data.data.Triangle(:,[1,3])',1);
r1=num2cell(data.data.Right(:,[1,3])',1);
d1=num2cell(data.data.Down(:,[1,3])',1);
c2=num2cell(data.data.Circle(:,[5,7])',1);
t2=num2cell(data.data.Triangle(:,[5,7])',1);
r2=num2cell(data.data.Right(:,[5,7])',1);
d2=num2cell(data.data.Down(:,[5,7])',1);
c3=num2cell(data.data.Circle(:,[9,11])',1);
t3=num2cell(data.data.Triangle(:,[9,11])',1);
r3=num2cell(data.data.Right(:,[9,11])',1);
d3=num2cell(data.data.Down(:,[9,11])',1);

dval=[c3,t3,r3,d3];

data_train=[c1,t1,r1,d1,c2,t2,r2,d2];

h1=foldnarx(data_train,dval);%fold1

data_train=[c2,t2,r2,d2,c3,t3,r3,d3];
dval=[c1,t1,r1,d1];
h2=foldnarx(data_train,dval);%fold2

data_train=[c1,t1,r1,d1,c3,t3,r3,d3];
dval=[c2,t2,r2,d2];
h3=foldnarx(data_train,dval);%fold2

ezroc3(cat(3,h1,h2,h3),[],2,'RoC Curve-Validation',1)
