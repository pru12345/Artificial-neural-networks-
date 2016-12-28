clear all;
close all;
clc;


m_dir='./att_faces/';
b=[];
s_Folder = dir(strcat(m_dir,'s*'));

for i=1:length(s_Folder)
    fld=strcat(m_dir,s_Folder(i).name,'/');
    s_img=dir(strcat(fld,'*.pgm'));
    for j=1:length(s_img)
        a=imread(strcat(fld,s_img(j).name));
        b{(i-1)*10+j}=im2double(a);
%         a=im2double(a);
%         a=num2cell(a);
%         b=[b;a];
    end   
end

for i =1:40
    train{(i-1)*6+1}=b{(i-1)*10+1};
    train{(i-1)*6+2}=b{(i-1)*10+2};
    train{(i-1)*6+3}=b{(i-1)*10+3};
    train{(i-1)*6+4}=b{(i-1)*10+4};
    train{(i-1)*6+5}=b{(i-1)*10+5};
    train{(i-1)*6+6}=b{(i-1)*10+6};
    
    test{(i-1)*4+1}=b{(i-1)*10+7};
    test{(i-1)*4+2}=b{(i-1)*10+8};
    test{(i-1)*4+3}=b{(i-1)*10+9};
    test{(i-1)*4+4}=b{(i-1)*10+10};
end


t=im2double(eye(40));
target_train=[];
target_test=[];
for i=1:40
    target_train(:,(i-1)*6+1)=t(:,i);
    target_train(:,(i-1)*6+2)=t(:,i);
    target_train(:,(i-1)*6+3)=t(:,i);
    target_train(:,(i-1)*6+4)=t(:,i);
    target_train(:,(i-1)*6+5)=t(:,i);
    target_train(:,(i-1)*6+6)=t(:,i);
    
    
    target_test(:,(i-1)*4+1)=t(:,i);
    target_test(:,(i-1)*4+2)=t(:,i);
    target_test(:,(i-1)*4+3)=t(:,i);
    target_test(:,(i-1)*4+4)=t(:,i);
    
    
end
