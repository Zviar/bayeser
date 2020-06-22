clc;
close all;
clear all;
img = imread('js3.jpg');
img = rgb2gray(img);
img2 = imbinarize(img);%二值化
numVal_1 = sum(sum(img2));%二值化图片1的数量
numVal_0 = length(find(img2==0));%二值化图片0的数量
if numVal_0 < numVal_1
    [m,n] = size(img2);
    img2 = ones(m,n)-img2;
else
    img = 255 - img;%反转灰度图
end
L = bwlabel(img2);%标记连通区域
stats = regionprops(L);
num = length(stats); %连通域总个数
if num > 0
    for i = 1:num 
        
        b = stats(i).BoundingBox;
        img3 = imcrop(img,[b(1)-1,b(2)-1,b(3)+2,b(4)+2]);
        img3=imresize(img3,[25,25]);%缩小尺寸
        data(i) = bayeser(img3);
        subplot(1,num,i),imshow(img3);
        title(data(i));
    end
    fprintf("识别数字结果为:");fprintf("%d",data);
    
else
    fprintf("没有可识别字符")
end

