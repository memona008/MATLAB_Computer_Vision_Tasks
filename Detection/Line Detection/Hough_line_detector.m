
function [r,theta,m,c] = Hough_line_detector(I)
% m = 2;
% c = 4;
% x = 20:1:100;
% y = round(m*x+c + 5*randn(size(x)));
% I = zeros(max(x),max(y));
% I(sub2ind(size(I),x,y))=1;
% I(10,100) = 1;
% I(60,10:3:100) = 1;
% I(10,102) = 1;
% I(60,14) = 1;
% comment above code if you want to pass your own image
I = double(I);
[rows,cols] = size(I);
[X,Y] = find(I==1);
rMax = ((rows^2)+(cols^2))^0.5;
rMax = ceil(rMax);
n = length(X);
A = zeros(rMax,360);
for i = 1:n
    xi = X(i);
    yi = Y(i);
    for o = 1:1:360
        r = round(abs(xi*cosd(o)+yi*sind(o)));   
        if r==0
            r=1;
        end
        A(r,o) = A(r,o)+1;
    end
end
[r,theta] = find(A==max(A(:)));
n = length(r);
m = zeros(n);
c = zeros(n);
for k = 1:1:n
%figure;
m(k) = -1*cosd(theta(k))/sind(theta(k));
c(k) = round(r(k)/sind(theta(k)));
%i = f_drawLine(double(I),m(k),c(k)); 
%imshow(i);
end
end

function  i=f_drawLine(I,M,C)
red =I;
green=I;
blue=I;
 [r,c] = size(I);
 for x =1:1:r
     for y = 1:1:c
        t = round(M*x+C);
            if t==y
                red(x,y)=255;
                green(x,y)=0;
                blue(x,y)=0;
              
            end
     end
 end
 i=cat(3,red,green,blue); 

end