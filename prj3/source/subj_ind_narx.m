data1=importdata('Person1.xls',' ',3);
data2=importdata('Person2.xls',' ',3);
data3=importdata('Person3.xls',' ',3);
data4=importdata('Person4.xls',' ',3);
data5=importdata('Person5.xls',' ',3);
data6=importdata('Person6.xls',' ',3);


u2c1=num2cell(data2.data.Circle(:,[1,3])',1);
u2t1=num2cell(data2.data.Triangle(:,[1,3])',1);
u2r1=num2cell(data2.data.Right(:,[1,3])',1);
u2d1=num2cell(data2.data.Down(:,[1,3])',1);
u2c2=num2cell(data2.data.Circle(:,[5,7])',1);
u2t2=num2cell(data2.data.Triangle(:,[5,7])',1);
u2r2=num2cell(data2.data.Right(:,[5,7])',1);
u2d2=num2cell(data2.data.Down(:,[5,7])',1);
u2c3=num2cell(data2.data.Circle(:,[9,11])',1);
u2t3=num2cell(data2.data.Triangle(:,[9,11])',1);
u2r3=num2cell(data2.data.Right(:,[9,11])',1);
u2d3=num2cell(data2.data.Down(:,[9,11])',1);


u3c1=num2cell(data3.data.Circle(:,[1,3])',1);
u3t1=num2cell(data3.data.Triangle(:,[1,3])',1);
u3r1=num2cell(data3.data.Right(:,[1,3])',1);
u3d1=num2cell(data3.data.Down(:,[1,3])',1);
u3c2=num2cell(data3.data.Circle(:,[5,7])',1);
u3t2=num2cell(data3.data.Triangle(:,[5,7])',1);
u3r2=num2cell(data3.data.Right(:,[5,7])',1);
u3d2=num2cell(data3.data.Down(:,[5,7])',1);
u3c3=num2cell(data3.data.Circle(:,[9,11])',1);
u3t3=num2cell(data3.data.Triangle(:,[9,11])',1);
u3r3=num2cell(data3.data.Right(:,[9,11])',1);
u3d3=num2cell(data3.data.Down(:,[9,11])',1);

u4c1=num2cell(data4.data.Circle(:,[1,3])',1);
u4t1=num2cell(data4.data.Triangle(:,[1,3])',1);
u4r1=num2cell(data4.data.Right(:,[1,3])',1);
u4d1=num2cell(data4.data.Down(:,[1,3])',1);
u4c2=num2cell(data4.data.Circle(:,[5,7])',1);
u4t2=num2cell(data4.data.Triangle(:,[5,7])',1);
u4r2=num2cell(data4.data.Right(:,[5,7])',1);
u4d2=num2cell(data4.data.Down(:,[5,7])',1);
u4c3=num2cell(data4.data.Circle(:,[9,11])',1);
u4t3=num2cell(data4.data.Triangle(:,[9,11])',1);
u4r3=num2cell(data4.data.Right(:,[9,11])',1);
u4d3=num2cell(data4.data.Down(:,[9,11])',1);

u5c1=num2cell(data5.data.Circle(:,[1,3])',1);
u5t1=num2cell(data5.data.Triangle(:,[1,3])',1);
u5r1=num2cell(data5.data.Right(:,[1,3])',1);
u5d1=num2cell(data5.data.Down(:,[1,3])',1);
u5c2=num2cell(data5.data.Circle(:,[5,7])',1);
u5t2=num2cell(data5.data.Triangle(:,[5,7])',1);
u5r2=num2cell(data5.data.Right(:,[5,7])',1);
u5d2=num2cell(data5.data.Down(:,[5,7])',1);
u5c3=num2cell(data5.data.Circle(:,[9,11])',1);
u5t3=num2cell(data5.data.Triangle(:,[9,11])',1);
u5r3=num2cell(data5.data.Right(:,[9,11])',1);
u5d3=num2cell(data5.data.Down(:,[9,11])',1);

u6c1=num2cell(data6.data.Circle(:,[1,3])',1);
u6t1=num2cell(data6.data.Triangle(:,[1,3])',1);
u6r1=num2cell(data6.data.Right(:,[1,3])',1);
u6d1=num2cell(data6.data.Down(:,[1,3])',1);
u6c2=num2cell(data6.data.Circle(:,[5,7])',1);
u6t2=num2cell(data6.data.Triangle(:,[5,7])',1);
u6r2=num2cell(data6.data.Right(:,[5,7])',1);
u6d2=num2cell(data6.data.Down(:,[5,7])',1);
u6c3=num2cell(data6.data.Circle(:,[9,11])',1);
u6t3=num2cell(data6.data.Triangle(:,[9,11])',1);
u6r3=num2cell(data6.data.Right(:,[9,11])',1);
u6d3=num2cell(data6.data.Down(:,[9,11])',1);

user1=[u1c1 u1t1 u1r1 u1d1 u1c2 u1t2 u1r2 u1d2 u1c3 u1t3 u1r3 u1d3 ];
user2=[u2c1 u2t1 u2r1 u2d1 u2c2 u2t2 u2r2 u2d2 u2c3 u2t3 u2r3 u2d3 ];
user3=[u3c1 u3t1 u3r1 u3d1 u3c2 u3t2 u3r2 u3d2 u3c3 u3t3 u3r3 u3d3 ];
user4=[u4c1 u4t1 u4r1 u4d1 u4c2 u4t2 u4r2 u4d2 u4c3 u4t3 u4r3 u4d3 ];
user5=[u5c1 u5t1 u5r1 u5d1 u5c2 u5t2 u5r2 u5d2 u5c3 u5t3 u5r3 u5d3 ];
user6=[u6c1 u6t1 u6r1 u6d1 u6c2 u6t2 u6r2 u6d2 u6c3 u6t3 u6r3 u6d3 ];

data_train=[user1 user2 user3 user4 user5];
target= user6 ;
h1= int_narx(data_train,target) ;

data_train=[user1 user2 user3 user4 user6];
target= user5 ;

h2= int_narx(data_train,target) ;

data_train=[user1 user2 user3 user5 user6];
target= user4 ;

h3= int_narx(data_train,target) ;

data_train=[user1 user2 user4 user5 user6];
target= user3;

h4= int_narx(data_train,target) ;

data_train=[user1 user3 user4 user5 user6];
target= user2;

h5= int_narx(data_train,target) ;

data_train=[user2 user3 user4 user5 user6];
target= user1;

h6= int_narx(data_train,target) ;

ezroc3(cat(3,h1,h2,h3,h4,h5,h6),[],2,'RoC Curve-Validation',1)




