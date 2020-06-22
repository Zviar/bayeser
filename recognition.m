clc;
close all;
clear all;
img = imread('js3.jpg');
img = rgb2gray(img);
img2 = imbinarize(img);%��ֵ��
numVal_1 = sum(sum(img2));%��ֵ��ͼƬ1������
numVal_0 = length(find(img2==0));%��ֵ��ͼƬ0������
if numVal_0 < numVal_1
    [m,n] = size(img2);
    img2 = ones(m,n)-img2;
else
    img = 255 - img;%��ת�Ҷ�ͼ
end
L = bwlabel(img2);%�����ͨ����
stats = regionprops(L);
num = length(stats); %��ͨ���ܸ���
if num > 0
    for i = 1:num 
        
        b = stats(i).BoundingBox;
        img3 = imcrop(img,[b(1)-1,b(2)-1,b(3)+2,b(4)+2]);
        img3=imresize(img3,[25,25]);%��С�ߴ�
        data(i) = bayeser(img3);
        subplot(1,num,i),imshow(img3);
        title(data(i));
    end
    fprintf("ʶ�����ֽ��Ϊ:");fprintf("%d",data);
    
else
    fprintf("û�п�ʶ���ַ�")
end

