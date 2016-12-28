for i=1:6
data(i)=importdata(strcat('Person',num2str(i),'.xls'),' ',3);
end

data1=num2cell([(data(1).data.Circle(:,[1,3]));(data(1).data.Circle(:,[5,7]));(data(1).data.Circle(:,[9,11]));
(data(1).data.Triangle(:,[1,3]));(data(1).data.Triangle(:,[5,7]));(data(1).data.Triangle(:,[9,11]));
(data(1).data.Right(:,[1,3]));(data(1).data.Right(:,[5,7]));(data(1).data.Right(:,[9,11]));
(data(1).data.Down(:,[1,3]));(data(1).data.Down(:,[5,7]));(data(1).data.Down(:,[9,11]))]',1);

data2=num2cell([(data(2).data.Circle(:,[1,3]));(data(2).data.Circle(:,[5,7]));(data(2).data.Circle(:,[9,11]));
(data(2).data.Triangle(:,[1,3]));(data(2).data.Triangle(:,[5,7]));(data(2).data.Triangle(:,[9,11]));
(data(2).data.Right(:,[1,3]));(data(2).data.Right(:,[5,7]));(data(2).data.Right(:,[9,11]));
(data(2).data.Down(:,[1,3]));(data(2).data.Down(:,[5,7]));(data(2).data.Down(:,[9,11]))]',1);

data3=num2cell([(data(3).data.Circle(:,[1,3]));(data(3).data.Circle(:,[5,7]));(data(3).data.Circle(:,[9,11]));
(data(3).data.Triangle(:,[1,3]));(data(3).data.Triangle(:,[5,7]));(data(3).data.Triangle(:,[9,11]));
(data(3).data.Right(:,[1,3]));(data(3).data.Right(:,[5,7]));(data(3).data.Right(:,[9,11]));
(data(3).data.Down(:,[1,3]));(data(3).data.Down(:,[5,7]));(data(3).data.Down(:,[9,11]))]',1);

data4=num2cell([(data(4).data.Circle(:,[1,3]));(data(4).data.Circle(:,[5,7]));(data(4).data.Circle(:,[9,11]));
(data(4).data.Triangle(:,[1,3]));(data(4).data.Triangle(:,[5,7]));(data(4).data.Triangle(:,[9,11]));
(data(4).data.Right(:,[1,3]));(data(4).data.Right(:,[5,7]));(data(4).data.Right(:,[9,11]));
(data(4).data.Down(:,[1,3]));(data(4).data.Down(:,[5,7]));(data(4).data.Down(:,[9,11]))]',1);

data5=num2cell([(data(5).data.Circle(:,[1,3]));(data(5).data.Circle(:,[5,7]));(data(5).data.Circle(:,[9,11]));
(data(5).data.Triangle(:,[1,3]));(data(5).data.Triangle(:,[5,7]));(data(5).data.Triangle(:,[9,11]));
(data(5).data.Right(:,[1,3]));(data(5).data.Right(:,[5,7]));(data(5).data.Right(:,[9,11]));
(data(5).data.Down(:,[1,3]));(data(5).data.Down(:,[5,7]));(data(5).data.Down(:,[9,11]))]',1);

data6=num2cell([(data(6).data.Circle(:,[1,3]));(data(6).data.Circle(:,[5,7]));(data(6).data.Circle(:,[9,11]));
(data(6).data.Triangle(:,[1,3]));(data(6).data.Triangle(:,[5,7]));(data(6).data.Triangle(:,[9,11]));
(data(6).data.Right(:,[1,3]));(data(6).data.Right(:,[5,7]));(data(6).data.Right(:,[9,11]));
(data(6).data.Down(:,[1,3]));(data(6).data.Down(:,[5,7]));(data(6).data.Down(:,[9,11]))]',1);

H1=call_tdnnSI([data1 data2 data3 data4 data5],data6);
H2=call_tdnnSI([data1 data2 data3 data4 data6],data5);
H3=call_tdnnSI([data1 data2 data3 data5 data6],data4);
H4=call_tdnnSI([data1 data2 data4 data5 data6],data3);
H5=call_tdnnSI([data1 data3 data4 data5 data6],data2);
H6=call_tdnnSI([data2 data3 data4 data5 data6],data1);

ezroc3(cat(3,H1,H2,H3,H4,H5,H6),[],2,'roc',1);