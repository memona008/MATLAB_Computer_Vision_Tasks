 function i2 = f_edge(i)
         i2 = i;
         [r c ] = size(i);
         
         for x = 1 : r-1 
             for y= 1 : c-1 
              d1 = i(x+1,y) - i (x,y) ;
                d2 = i(x,y+1) - i (x,y);
                
                a =  d1*d1 + d2*d2;
                a =round(sqrt(double(a)));
                
                i2(x,y) = 0;
                    %i2(x+1,y+1) = 0;
                if(a>=16)
                    i2(x,y)=255;
                    % i2(x+1,y+1) = 255;
                end
             end
         end
 
 
 end

function i2 = f_edge(i)
        i2 = i;
        [r c ] = size(i);
        d1 = imfilter(i,[-1 1]');
        d2 = imfilter(i,[-1 1]);
        
        a =  d1.*d1 + d2.*d2;
        a =round(sqrt(double(a)));
        for x = 1:r-1
           for y = 1:c-1
               i2(x,y) = 0;
                   
               if(a(x,y)>=16)
                   i2(x,y)=255;
                
               end
            end
        end


end