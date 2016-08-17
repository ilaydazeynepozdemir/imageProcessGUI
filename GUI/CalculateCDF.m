function [ cdfMatrix ] = CalculateCDF( imageMatrix )
imageMatrix=uint8(imageMatrix);
row = size(imageMatrix,1);
col = size(imageMatrix,2);
% imshow(imageMatrix);
counter =0;
freq=zeros(1,256);
N=row*col;
thisOut = zeros(row,col);
for i=1 : row
    for j=1 : col
        value = imageMatrix(i,j);
        freq(value+1) = freq(value+1) + 1;
        pdf(value+1) = freq(value+1)/N;
    end
end
sum = 0;
for index=1:size(pdf,2)
    sum = sum + pdf(index);
    cdfMatrix(index) = double(sum);
end
end

