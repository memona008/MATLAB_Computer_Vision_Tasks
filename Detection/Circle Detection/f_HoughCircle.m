[X Y] = find(i==1);
n=size(X,1);
[r c] = size(i);
maxR= round(sqrt(r^2 + c^2));
mat=zeros(r,c,maxR);
for j = 1: n
    x=X(j);
    y=Y(j);
    for a= 1:r-1
        for b = 1:c-1
            R = round(sqrt((x-a)^2 + (y -b)^2));
            if R>0
                mat(a,b,R)=mat(a,b,R)+1;
            end
            
        end
    end
end
 [MaxVal , I] = max(mat(:));
 
 [ h,k,R]=ind2sub(size(i),I) %without non maxima suppression
 %Till now the circle with maximum votes is not necessarily accurate 
 
 
 
 
 %Applying maxima supression
 mat2=mat;
 % [ a b c ] = size(mat);
  
 
 %temp=find(mat(:)==MaxVal);
 %for j=1:size(temp,1)
     
 %end

 
 
 
 
    

