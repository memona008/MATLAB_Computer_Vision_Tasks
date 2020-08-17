m = 2;
c = 4;
x = 20:1:100;
y = round(m*x+c + 5*randn(size(x)));

I = zeros(max(x),max(y));

I(sub2ind(size(I),x,y))=1;
I(10,100) = 1;
I(60,10) = 1;
I(10,102) = 1;
I(60,14) = 1;
%imagesc(I);colormap gray;
k = 200;
[X,Y] = find(I==1);
n = length(X);
th = 5;
bestScore = 0;
bestM = 0; bestC = 0;

for i = 1:k
   idx = randperm(n);
   p = idx(1); q = idx(2);
   x1 = X(p); y1 = Y(p);
   x2 = X(q); y2 = Y(q);
   A = [x1 1;x2 1]; b = [y1;y2];
   mc = inv(A)*b;
   m = mc(1); c = mc(2);
   sj = 0;
   for j = 1:n
       dj = abs(m*X(j)+c-Y(j));
       if dj<=th
          sj = sj+1; 
       end
   end
   if sj>bestScore
      bestM = m;
      bestC = c;
      bestScore = sj;
   end
end

disp([m c]);

