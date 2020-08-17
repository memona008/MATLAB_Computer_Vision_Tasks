function  i=f_circle(I,h,k,R)




red =I;
green=I;
blue=I;
 [r c] = size(I);
 for x =1:1:r
     for y = 1:1:c
         b = (x-h)^2 + (y - k)^2 ;
            if round(sqrt(b))==R
           
                red(x,y)=255;
                greed(x,y)=0;
                blue(x,y)=0;
              

            end
     end
 end
 i=cat(3,red,green,blue);
 imshow(i);
 
 

end
