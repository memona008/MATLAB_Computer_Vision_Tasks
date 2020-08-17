I = imread('scanned7.tif');
I = rgb2gray(I);
B = I>170;
%ss=strel('square',7);
  %B=imerode(B,ss);
[L,num] = bwlabel(imfilter(B,fspecial('gaussian',7,3)));
for i = 1:length(unique(L(:)))-1
    N = L==i;
  
    EdgeN = edge(N,'canny');
[r,theta,m,c] = Hough_line_detector(logical(EdgeN));
%imshow(EdgeN),figure;
%ca=I(N==1);
%ca=imcrop(I);
angle=atand(m(1));
rotMat= [ cosd(90), -sind(90) ,0 ; sind(90), cosd(90), 0 ; 0 ,0, 1];
rotMat= rotMat * [ cosd(-angle),-sind(-angle),0 ; sind(-angle),cosd(-angle), 0 ; 0 ,0, 1];
%ca=f_transform(rotMat,ca);
E=EdgeN;
actual=I;
E=f_transform(rotMat,E );
actual=f_transform(rotMat,actual );
 [x y]=find(E);
 Xmin=min(x);Xmax=max(x);
 Ymin=min(y);Ymax=max(y);
 result=imresize(actual(Xmin:Xmax,Ymin:Ymax,:),[200 300]);
figure;
imshow(uint8(result));
pause;
end


