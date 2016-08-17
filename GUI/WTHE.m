function [out] = WTHE(im,v,r)

row = size(im,1);
col = size(im,2);

counter = 0;

for value = 0:255
    for i = 1:row
        for j= 1:col
            if (im(i,j) == value)
                counter = counter +1 ;
            end    
        end
    end
    P(value+1) = double(counter /(row*col));   %pdf calculation 
    counter = 0;
end

%% CDF calculation
temp =0;
for index = 1: size(P,2)

    temp = temp + P(index);
    C(index) = temp; % cdf calculation

end

%%
P_max=max(P);
P_u = P_max*v; %% Upper Limit, v= upper threshold normalized to Pmax, 0<v<1
P_l = 0; %% not specified currently




%% Calculate Weighted threshold PDF
for i = 1:size(P,2)
    
    if P(i) > P_u
        
        P_wt(i) = P_u;
        
    elseif ((P_l<=P(i)) && (P(i)<=P_u))
        
        P_wt(i) = (((P(i)-P_l) / (P_u - P_l))^r)*P_u;
        
    elseif P(i) < P_l
        P_wt(i) = P_l;
            
    end
end
%% median hesaplama kismi
% M_1 = median(P,size(P,1));
% M_2 = median(P_wt,size(P_wt,1));
% M_f = zeros(1,size(M_1,2));
% 
% for i=1:size(M_1,2)
%     M_f(i) = abs( M_2(i)-M_1(i));  
% end
%%



%% Calculate Weighted threshold CDF
temp =0;
for index = 1: size(P_wt,2)

    temp = temp + P_wt(index);
    C_wt(index) = temp;

end



%% 

% T = mean(im(:));
% 
% thr_im = im > T;
% for i= 1:row
%     for j= 1:255
%         
%         if thr_im == true
%         
%         else
%         end
%     end
% end
%% Output
C_WT_MATRIX = zeros (size(im,1), size (im,2));

W_out = max(im(:)) - min(im(:));


for i = 1: row
    for j = 1:col
        
        m = im(i,j);
        C_WT_MATRIX(i,j)=W_out*C_wt(1,m+1);
%         C_WT_MATRIX(i,j)=W_out*C_wt(1,m+1)+M_f(m+1) ;

    end
end


  out= uint8(C_WT_MATRIX);
%  figure;
%  imshow(out);
%  title('WTHE RESULT');
%  
%  imwrite (out,'WTHE_result.jpg');
%  figure;histogram(out);title('WTHE histogram')
 
 
 
end

