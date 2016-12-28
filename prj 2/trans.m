function [z]=trans(r)
for k=1:size(r,2)
    if (r(k)>=0);
        r(k)=1;
    else
        r(k)=0;
    end;
end;
z=r;
end