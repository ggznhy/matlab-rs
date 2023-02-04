% 实验三 遥感图像融合

% 示例效果不是很合适，可用qb_boulder文件夹中数据进一步演示

%% 小波变换融合
X1=data(:, :, 2);
min_val = min(min(X1));
max_val = max(max(X1));
for i = 1:lines
    for j = 1:samples
        X1(i,j) = (X1(i,j) - min_val) / (max_val - min_val) * 255;
    end
end
X1 = double(X1) / 256;
figure;
imshow(X1), title('高分辨率');
axis square;
X2= data(:, :, 4);
min_val = min(min(X2));
max_val = max(max(X2));
for i= 1:lines
    for j= 1:samples
        X2(i,j) = (X2(i, j) - min_val) / (max_val - min_val) * 255;
    end
end
X2 = double(X2 ) / 256;
figure;
imshow(X2), title('低分辨率');
axis square;
[c1,s1]= wavedec2(X1, 2, 'sym4 ');
%将x1进行2维,使用'sym4 '进行变换
sizec1 = size(c1);
for i= 1 : sizec1(2)
    c1(i)= 1.2 * c1(i);
    %将分解后的值都扩大1.2倍
end
[c2,s2] = wavedec2(X2, 2, 'sym4 ');
c=c1 + c2;
%计算平均值
c=0.5*c;
s=s1 + s2;
s=0.5 * s;
xx = waverec2(c,s,' sym4 ');
%进行重构
figure; imshow(xx), title('融合后的遥感图像');
axis square;

%% 自带工具箱小波低频和高频融合

X1 = data(:, :, 4);
min_val = min(min(X1));
max_val = max(max(X1));
for i= 1:lines
    for j = 1: samples
        X1(i, j) = (X1(i, j) - min_val) / (max_val - min_val) * 255;
    end
end

X2 = data(:, :, 2);
min_val = min(min(X2));
max_val = max(max(X2));
for i = 1:lines
    for j= 1:samples
        X2(i,j) = (X2(i, j) - min_val) / (max_val - min_val) * 255;
    end
end

XFUS = wfusimg(X1, X2,' sym4 ', 5, 'max', 'max');
min_val = min(min(XFUS));
max_val = max(max(XFUS));
for i= 1 : lines
    for j= 1 : samples
        XFUS(i, j) = (XFUS(i, j) - min_val) / ( max_val - min_val) * 255;
    end
end
%显示融合后图像
X1 = uint8(X1);
X2 = uint8(X2);
XFUS= uint8(XFUS);
subplot(131), imshow(X1), axis square, title('高分辨率');
subplot(132), imshow(X2), axis square, title('低分辨率');
subplot(133), imshow(XFUS), axis square, title('融合后图像');


