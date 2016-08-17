function [pos] = findObjects( Orj_img ,choise )
[rows, columns, numberOfColorChannels] = size(Orj_img);
if numberOfColorChannels > 1
    img     = rgb2gray(Orj_img);
else img = Orj_img;
end
wthe = WTHE(img,0.3,0.5);
bw = im2bw(img);
%goruntunun kendisi ve tersinin bilgileri 
stats = [regionprops(bw); regionprops(not(bw))];

for i=1:numel(stats)
    if(stats(i).Area > 1000)
        %Alani 1000 ve 1000'den kucuk olanlar ortalamaya katilmayacak
        area(i,1) = stats(i).Area;
    end
end

meanArea = mean(area(:));
% sortArea = sortrows(area);
% % choise parametresiyle secilen goruntu uzerinde cizim yapilir
% figure;GUI'de img'de goruntulenmesini engelliyor
if(strcmp(choise,'orginal'))
    imshow(Orj_img,[]);
elseif(strcmp(choise,'wthe'))
    imshow(wthe,[]);
elseif(strcmp(choise,'gray'))
    imshow(img,[]);
elseif(strcmp(choise,'binary'))
    imshow(bw,[]);
end
% %

hold on;
index = 1;
for i = 1:numel(stats)
    
    if stats(i).Area >= meanArea
        rec = rectangle('Position', stats(i).BoundingBox, ...
            'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '-');
        temp = get(rec,'Position');
        %% rec icindeki positioni once temp objesine attik sonra array icine doldurduk
        for t=1 : 4
            pos(index,t) = temp(1,t);
        end
        index = index + 1;
        %%
    end
end

end

