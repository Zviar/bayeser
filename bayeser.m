function [numresult] = bayeser(img)
%img----��ʶ������ͼ�� ����С��Ӿ��Σ�
%num-------ʶ������0-9)
%img=imresize(img,[25,25]);%��С�ߴ�
index=1;
for i=1:5:21
    for j=1:5:21
        temp=img(i:i+4,j:j+4);%��ȡ5*5�ķ���
        data(index)=1-sum(sum(temp))*1.0/(25*255);%��temp�еĻҶ�ֵ���������data����
        index=index+1;
    end
end


load pattern.mat pattern;
sum1 = 0;
pw = []; %�������
pwx = [];   %�������
%��ȡ�������
sum2 = pattern(1).num;
for i = 1:10
    sum1 = sum1+pattern(i).num;%����num�ĺ�
end
for i = 1:10
    pw(i) = pattern(i).num/sum1;
end

%������������ 10*25
for i = 1:10
    for j = 1:25
        sum1 = 0;
        for k = 1:pattern(i).num%1��130
            if(pattern(i).feature(j,k)>0.05)%������ֵ
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
%��������
sum1 = 0;
for i = 1:10
    sum1 = sum1+pw(i)*pxw(i);
end
for i = 1:10
    pwx(i) = pw(i)*pxw(i)/sum1;
end
[~,maxpos] = max(pwx);
numresult = maxpos-1


