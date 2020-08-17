function i2 = f_edge_canny_stack(i)
i  =double(i);
    s = fspecial('gaussian',7,3);
    dx= [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    dy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
%     dx = [1 0 -1];
%     dy = [1 0 -1]';
    Ix = imfilter(double(s),dx);
    Iy = imfilter(double(s),dy);
    Ix = imfilter(double(i),Ix);
    Iy = imfilter(double(i),Iy);
    [r,c] = size(Ix);
    Gm = double(sqrt((Ix.^2)+(Iy.^2)));
    Gd = double(atan2(Iy,Ix));
    
    angles = zeros(r,c);
    for x = 1:r
        for y = 1:c
            if(Gd(x,y)<0)
                Gd(x,y) = 360 + Gd(x,y);
            end
            angles(x,y) = findAngle(Gd(x,y));  
            if (Gd(x,y)>=180)
                Gd(x,y) = 360-Gd(x,y);
            end
        end
    end
    
   GMNMS = zeros(r,c);
  for x = 2:r-1
      for y = 2:c-1
          if angles(x,y)==45 || angles(x,y)==225 % angles(x,y)==135 || angles(x,y)==315  
              if Gm(x,y)>Gm(x+1,y+1) && Gm(x,y)>Gm(x-1,y-1)
                  GMNMS(x,y)= Gm(x,y);
              end     
          end     
           if  angles(x,y)==0 || angles(x,y)==360 || angles(x,y)==180 % angles(x,y)==90 || angles(x,y)==270
              
              if Gm(x,y)>Gm(x+1,y) && Gm(x,y)>Gm(x-1,y)
                  GMNMS(x,y)=Gm(x,y);
              end     
           end   
           if angles(x,y)==90 || angles(x,y)==270
                
              
              if Gm(x,y)>Gm(x,y+1) && Gm(x,y)>Gm(x,y-1)
                  GMNMS(x,y)=Gm(x,y);
              end     
           end
          
           
           if  angles(x,y)==135 || angles(x,y)==315
              
              if Gm(x,y)>Gm(x-1,y+1) && Gm(x,y)>Gm(x+1,y-1)
                  GMNMS(x,y)=Gm(x,y);
              end     
           end  
      end
  end
    
%     Th = mean(GMNMS(:))+1.5*std(GMNMS(:));
%     Th_H = Th;  
%     Th_L = Th*0.4; 
%     i2 = zeros(r,c);
%     for x = 1:r
%         for y = 1:c
%            
%             if GMNMS(x,y)>=Th_H
%                 i2(x,y)=255;
%             elseif GMNMS(x,y)<Th_L
%                 i2(x,y)=0;
%             elseif(GMNMS(x+1,y+1)>=Th_H || GMNMS(x-1,y-1)>=Th_H  || GMNMS(x+1,y)>=Th_H || GMNMS(x-1,y)>=Th_H || GMNMS(x,y+1)>=Th_H|| GMNMS(x,y-1)>=Th_H || GMNMS(x-1,y+1)>=Th_H|| GMNMS(x+1,y-1)>=Th_H)
%                 i2(x,y)=255;
%             end
%            
%         end
%     end
    

[rowSize,colSize] = size(i);
%  T_High = mean(GMNMS(:))+1.5*std(GMNMS(:));
%  T_Low = 0.4*T_High;
 T_Low = 0.075*max(GMNMS(:));
T_High = 0.175*max(GMNMS(:));
    
    T_res = zeros (rowSize,colSize);
    strongEdges=java.util.Stack();
   
    for i = 1 : rowSize
        for j = 1 : colSize
            if GMNMS(i,j) < T_Low
                T_res(i, j) = 0;
            elseif GMNMS(i,j) >T_High
                T_res(i, j) = 1;
                strongEdges.push([i;j]);
            elseif GMNMS(i,j) <=T_High && GMNMS(i,j)>=T_Low
                T_res(i,j) = 2;
                
            end
        end
    end
    
    visited = zeros (rowSize,colSize);
   
    while(strongEdges.empty()==false)
        cord=strongEdges.pop();
        x=cord(1,1);
        y=cord(2,1);
           if  visited(x,y)==0
                visited(x,y)=1;
              if T_res(x+1,y+1)==2
                  T_res(x+1,y+1)=1;
                  strongEdges.push([x+1;y+1]);
              end
              if T_res(x-1,y-1)==2
                   T_res(x-1,y-1)=1;
                  strongEdges.push([x-1;y-1]);
              end
              if T_res(x+1,y)==2
                   T_res(x+1,y)=1;
                  strongEdges.push([x+1;y]);
              end
              if T_res(x-1,y)==2
                   T_res(x-1,y)=1;
                  strongEdges.push([x-1,y]);
              end
              if T_res(x,y+1)==2
                   T_res(x,y+1)=1;
                  strongEdges.push([x;y+1]);
              end
              if T_res(x,y-1)==2
                   T_res(x,y-1)=1;
                  strongEdges.push([x;y-1]);
              end
              if T_res(x-1,y+1)==2
                   T_res(x-1,y+1)=1;
                  strongEdges.push([x-1;y+1]);
              end
              if T_res(x+1,y-1)==2
                   T_res(x+1,y-1)=1;
                  strongEdges.push([x+1;y-1]);
              end
             
           end   
           
    end
    %figure;
    %imshow(visited);
    %visited=zeros(x,y);
    i2=uint8(T_res.*255);
   
    
    
    
    
    
    
    
    
    
     end

                
       

function angle = findAngle(degs)

            if degs >= 0 && degs <= 45 
                if degs <= 22.5
                    angle = 0;
                else  
                    angle = 45; 
                end
            end
            
             if degs > 45 && degs <= 90
                if degs <= 68
                    angle = 45;
                else  
                    angle = 90; 
                end
            end
             
           if degs > 90 && degs <= 135  
                if degs <= 113
                    angle = 90;
                else  
                    angle = 135; 
                end
           end
            
           
            if degs > 135 && degs <= 180  
                if degs <= 158
                    angle = 135;
                else  
                    angle = 180; 
                end
            end
                   
          if degs > 180 && degs <= 225 
                if degs <= 203
                    angle = 180;
                else  
                    angle = 225; 
                end
            end
             
            if degs > 225 && degs <= 270 
                if degs <= 248
                    angle = 225;
                else  
                    angle = 270; 
                end
            end
            
             if degs > 270 && degs <= 315 
                if degs <= 293
                    angle = 270;
                else  
                    angle = 315; 
                end
            end
             
           
         if degs > 315 && degs <= 360
                if degs <= 338
                    angle = 315;
                else  
                    angle = 360; 
                end
         end
             
        

end