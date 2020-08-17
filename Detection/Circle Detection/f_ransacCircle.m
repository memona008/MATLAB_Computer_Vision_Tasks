function f_ransacCircle()
count=0;
h=200;
k=200;
a = zeros(500,500);
i=a;
[r1 c1] = size(a);
 
for x =1:1:r1
     for y = 1:1:c1
         b = (x-h)^2 + (y - k)^2 ;
          if round(sqrt(b))==100.0
          f= round(40*rand());
          g= round(40*rand());
          a((x+f),(y+g))=1;
          count=count+1;
          end
     end
 end
 a(100,200)=1;
 a(340,300)=1;
 a(321,273)=1;
 a(130,245)=1;
 a(156,242)=1;
 a(123,203)=1;
 a(192,250)=1;
 a(200,376)=1;
 a(346,260)=1;
 a(192,490)=1;
 i=a;
%imshow(a);
I = i;
K = 100;
[X,Y] = find(i==1);
n = length(X);
th = 5;
bestScore = 0;
bestH = 0;
bestK = 0;
bestR = 0;

for l = 1:K
   idx = randperm(n);
   p = idx(1);
   q = idx(2);
   s = idx(3);
   x1 = X(p); y1 = Y(p);
   x2 = X(q); y2 = Y(q);
   x3 = X(s); y3 = Y(s);
   
   sqrx1 = x1^2; 
   sqrx2 = x2^2;
   sqrx3 = x3^2;
   
   sqry1 = y1^2;
   sqry2 = y2^2;
   sqry3 = y3^2;
   
   %A = [x1 y1 1;x2 y2 1; x3 y3 1];
   %b = [sqrx1+sqry1; sqrx2+sqry2; sqrx3+sqry3];
   %hkr = inv(A)*b;
   %h = hkr(1); k = hkr(2); r = abs(hkr(3));
   A = [(sqrx1+sqry1) y1 1;(sqrx2+sqry2) y2 1;(sqrx3+sqry3) y3 1]; 
   B = [x1 (sqrx1+sqry1) 1;x2 (sqrx2+sqry2) 1;x3 (sqrx3+sqry3) 1];
   C =[x1 y1 1; x2 y2 1; x3 y3 1];
   
h= round(det(A)/(2*det(C)));
k=round(det(B)/(2*det(C)));
r = round(sqrt((x1-h)^2 +(y1-k)^2));% every point lying on circle has same radius so we
%can measure radius using any of the 3 points
sj = 0; 
   for j = 1:n
       dj = round(abs(sqrt((X(j)-h)^2 +(Y(j)-k)^2) - r));
       if dj<=th
          sj = sj+1; 
       end
   end

   if sj > bestScore
      bestH = h;
      bestK = k;
      bestR = r;
      bestScore = sj;
   end
end
red =I;
green=I;
blue=I;
 [r1, c1] = size(I);
 for x =1:1:r1
     for y = 1:1:c1
         b = sqrt((x-bestH)^2 + (y - bestK)^2);
            if round(b) == bestR           
                red(x,y)=255;
                green(x,y)=0;
                blue(x,y)=0;
            end
     end
 end
 I=cat(3,red,green,blue);
 imshow(I);
end