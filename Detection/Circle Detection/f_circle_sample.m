function  i=f_circle()
count=0;
h=250;
k=250;

 a = zeros(500,500);
 i=a;
 [r c] = size(a);
 for x =1:1:r
     for y = 1:1:c
         b = (x-h)^2 + (y - k)^2 ;
            if round(sqrt(b))==100.0
          f= round(40*rand());
          g= round(40*rand());
           
                a((x+f),(y+g))=1;
              
count=count+1;
            end
     end
 end
 i=a;
 imshow(a);
 
 

end
