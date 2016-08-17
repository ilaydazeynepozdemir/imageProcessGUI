function  [img] = SimpleMask( im )
img = im;
[rows, columns, numberOfColorChannels] = size(img);
if numberOfColorChannels > 1
    img     = rgb2gray(img);
end

part = imcrop(img);

meanPart = mean(part(:));

img_h = size(img,1);
img_w = size(img,2);

mask_h = size(part,1);
mask_w = size(part,2);


% for i=1+floor(mask_h/2) : img_h-floor(mask_h/2)
%     for j=1+floor(mask_w/2) : img_w-floor(mask_w/2)
%         if( img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2)) < meanPart )
%             img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2)) = 1;
%         else img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2)) = 0;    
%         end
%     end
% end
for i=1+floor(mask_h/2) : img_h-floor(mask_h/2)
    for j=1+floor(mask_w/2) : img_w-floor(mask_w/2)
        patch =  img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2));
        avg = mean(patch);
        if patch <= meanPart
            img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2)) = 1;
        else
            img(i-floor(mask_h/2) :i+floor(mask_h/2),j-floor(mask_w/2):j+floor(mask_w/2)) = 0;
        end
    end
end

figure;imshow(img);

b = imbinarize(img);
figure;imshow(b);
return;
end

