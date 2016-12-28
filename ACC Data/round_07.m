function [z]=round_07(r)
[S]= size(r) ;
for i=1:S(1,1)
    for j=1:S(1,2)
    if r(i,j)>0.7
        r(i,j)=1;
    else 
        r(i,j)=-1;
    end
    end
    z=r;
end
