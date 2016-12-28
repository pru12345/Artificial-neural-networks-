x=[ones(1,6),zeros(1,234)];
for i=1:40
    target_train(i,:)=x;
    x=circshift(x,6,2);
end

y=[ones(1,4),zeros(1,156)];
for i=1:40
    target_test(i,:)=y;
    y=circshift(y,4,2);
end


[y,y1]=deepnet1(200,250,0.04,1,0.15,75,400,0.002,1,0.1);
[y2,y3]=deepnet1(150,200,0.02,3.5,0.15,50,400,0.04,2,0.15);
[y2,y3]=deepnet1(300,200,0.04,3.5,0.15,4,150,200,0.04,4,0.15);

y4=(y+y2)/2;
y5=(y1+y3)/2;
plotconfusion(target_train,y4);
plotconfusion(target_test,y5);
H=ezroc3(y4,target_train,2,' ',1);
