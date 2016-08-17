 function [ result ] = HistogramMatch(target,reference)

% target = imread(target); %HE uygulanmis
% reference = imread(reference); %input

[rows, columns, numberOfColorChannels] = size(reference);
if numberOfColorChannels > 1
    reference     = rgb2gray(reference);
end

row = size(reference,1);
col = size(reference,2);

hx = hist(double(reference)); %input histogram

hz = hist(double(target)); %HE uygulanmis histogram
Hx = CalculateCDF(hx);
Hz = CalculateCDF(hz);
j = 1;
lookup = zeros(1,256);
for i=1:255
    if Hx(i) <= Hz(j)
        lookup(i) = j;
    else while Hx(i) > Hz(j)
            if j+1 < size(Hz,2)
                j = j+1;
            else break;
            end
        end
       
        if ((Hz(j) - Hx(i)) > (Hx(i) - Hz(j-1)))
            lookup(i) = j-1;
        else lookup(i) = j;
        end
    end
end
%
% 
sign = false;
for k=1:256
    for i=1:row
        for j=1:col
            if k==reference(i,j)
                result(i,j) = lookup(k);
                count = [i j k];
                
                sign = true;
            elseif sign == false
                result(i,j) = reference(i,j);
            end
        end
    end
end
% %result icindeki double degerleri ,goruntu olusmasi icin, uint8 cevirdik.
% %

% figure;imshow(reference);title('referans goruntu');
% 
% figure;imshow(target);title('hedef goruntu (WTHE)');
% figure;imshow(imhistmatch(target,reference));title('imhistmatch');
% result=uint8(result);
% figure;
% imshow(result); title('HistogramMatch');
% figure;
% histogram(result); title('Esleþtirme yapilmis goruntunun histogrami');

 return ;
 end


