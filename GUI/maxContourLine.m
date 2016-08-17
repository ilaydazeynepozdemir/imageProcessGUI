function [ seg ] = maxContourLine( imgMatrix )
index=1;
i=1;
while index <= size(imgMatrix,2)
    segStart(i,:)=[index imgMatrix(2,index)];
    index=index+segStart(i,2)+1;
    i= i+1;
end
segmentation=sortrows(segStart,2);
% last entry points to longest contour

minx=segmentation(end,1);
mlen=segmentation(end,2);
seg=imgMatrix(:,minx+1:minx+mlen);
figure;
axes;
line(seg(1,:),seg(2,:),'color',[0 0 0],'linewidth',3);

end

