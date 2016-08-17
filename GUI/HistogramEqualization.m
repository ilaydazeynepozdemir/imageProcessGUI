function [ new ] = HistogramEqualization( img )
img=uint8(img);
row = size(img,1);
col = size(img,2);
out=zeros(1,256);
cdf = CalculateCDF(img);
 L=255;
for index=1:size(cdf,2)
    out(1,index) =round( cdf(index)*L);
end


for i=1:row
    for j=1:col
        if img(i,j)~= 0
         new(i,j)= out(img(i,j));
        end
    end
end
new=uint8(new);
return;
end

