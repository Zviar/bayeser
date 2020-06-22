function [numresult] = bayeser(img)
%img----待识别样本图像 （最小外接矩形）
%num-------识别结果（0-9)
%img=imresize(img,[25,25]);%缩小尺寸
index=1;
for i=1:5:21
    for j=1:5:21
        temp=img(i:i+4,j:j+4);%截取5*5的方框
        data(index)=1-sum(sum(temp))*1.0/(25*255);%将temp中的灰度值按次序存入data数组
        index=index+1;
    end
end


load pattern.mat pattern;
sum1 = 0;
pw = []; %先验概率
pwx = [];   %后验概率
%求取先验概率
sum2 = pattern(1).num;
for i = 1:10
    sum1 = sum1+pattern(i).num;%所有num的和
end
for i = 1:10
    pw(i) = pattern(i).num/sum1;
end

%求类条件概率 10*25
for i = 1:10
    for j = 1:25
        sum1 = 0;
        for k = 1:pattern(i).num%1：130
            if(pattern(i).feature(j,k)>0.05)%设置阈值
                sum1 = sum1+1;
            end
        end
        p(j,i) = (sum1+1)/(pattern(i).num+2);
    end
end

for i = 1:10
    sum1 = 1;
    for j = 1:25
        if(data(j)>0.05)
            sum1 = sum1*p(j,i);
        else
            sum1 = sum1*(1-p(j,i));
        end
    end
    pxw(i) = sum1;
end
%求后验概率
sum1 = 0;
for i = 1:10
    sum1 = sum1+pw(i)*pxw(i);
end
for i = 1:10
    pwx(i) = pw(i)*pxw(i)/sum1;
end
[~,maxpos] = max(pwx);
numresult = maxpos-1


