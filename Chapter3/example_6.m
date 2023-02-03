% 实验六 图像分割

% 图像分割是由图像处理得到图像分析的关键步骤，是图像识别和计算机视觉至关重要的预处理。图像分割后提取的目标可用于图像识别、
% 特征提取、图像搜索等领域。图像分割的基本策略主要是基于图像灰度值的两个特性，即灰度不连续和灰度相似性，因此图像分割可以基于
% 边缘的分割方法和基于区域的分割方法。本次实验通过完成简单的图像分割，进一步加深对图像分割的理解。

%% 相关函数
% edge:边缘监测函数
% graythresh: 利用Otsu算法(最大类间方差)获取全局阈值
% im2bw: 将灰度图像转换为二值图像
% bwtraceboundary: 在二值图像中追踪目标轮廓线
% hough: Hough 变换函数
% houghpeaks: hough变换峰值识别
% houghline: 基于hough变换提取线元

%% 简单图像阈值分割
% 利用直方图
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);  % RGB转灰度图像
subplot(221); imshow(I); title('灰度图像');
subplot(222); imhist(I); title('灰度直方图'), xlabel('灰度值'), ylabel('像元个数')
I2 = im2bw(I, 110/255);
subplot(223), imshow(I2); title('阈值为100的图像分割结果');
I3 = im2bw(I, 150/255);
subplot(224), imshow(I3); title('阈值为150的图像分割结果');

% 利用最大类间方差法（Otsu）自动确定阈值进行分割
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);  % RGB转灰度图像
subplot(121); imshow(I); title('原始图像');
level = graythresh(I);  % 确定灰度阈值
BW = im2bw(I, level);
subplot(122); imshow(BW); title('Otsu法图像分割结果');

%% 基于边缘的图像分割

% 利用各种边缘监测算子监测边缘
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\haha.jpg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);  % RGB转灰度图像
subplot(241); imshow(I); title('原始图像');
I1 = im2bw(I);  
subplot(242); imshow(I1); title('二值图像');
I2 = edge(I1, 'roberts');
subplot(243); imshow(I2); title('roberts算子检测结果');
I3 = edge(I1, 'prewitt');
subplot(244); imshow(I3); title('prewitt算子检测结果');
I4 = edge(I1, 'sobel');
subplot(245); imshow(I4); title('sobel算子检测结果');
I5 = edge(I1, 'canny');
subplot(246); imshow(I5); title('canny算子检测结果');
I6 = edge(I1, 'log');
subplot(247); imshow(I6); title('log算子检测结果');

% 边界跟踪bwtraceboundary函数
% 以Prewitt算子检测结果为例，绘制边界
BW = I3;
s = size(BW);
col = round(s(2)/2 - 90);  % 设置起始点列坐标
row = find(BW(:,col),1);  % 寻找起始点行坐标
connectivity = 8; % 设置八邻域寻找，缺省值
num_points = 18000000;
%提取边界
contour = bwtraceboundary(BW, [row,col], 'N', connectivity, num_points);
imshow(I); hold on;
% 在原图尚绘提取出的
plot(contour(:,2), contour(:,1), 'g', 'LineWidth',6);
title('边界跟踪图像')


%% Hough变换检测线段
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I1 = imread(filename);  % 读取图片
I1 = rgb2gray(I1);  % 转灰度
I = imrotate(I1,33,'crop');
BW = edge(I, 'canny');
subplot(231),imshow(I1),title('原始图像');
subplot(232),imshow(I),title('旋转后的图像');
subplot(233),imshow(BW),title('边缘检测图像');
[H,theta,rho] = hough(BW);  % Hough变换
subplot(234), hold on, imshow(imadjust(mat2gray(H)), [], 'XData', theta, 'YData',rho, 'Initialmagnification', 'fit');
title('峰值检测');
xlabel('\theta(degrees)'), ylabel('\rho');
axis on, axis normal, hold on
P = houghpeaks(H,10,'threshold', ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x, y, 's', 'color', 'red');
lines = houghlines(BW,theta,rho,P,'FillGap',5,'Minlength',7);
subplot(235), imshow(I);title('检测到的线段'); hold on  % 底图
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    % 绘制线段起终点
    plot(xy(1,1),xy(1,2),'LineWidth',2,'Color','green');  
    plot(xy(2,1),xy(2,2),'LineWidth',2,'Color','green');
    % 确定最长线段的端点
    len = norm(lines(k).point1 - lines(k).point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
% 突出显示最长一条线段
plot(xy_long(:,1), xy_long(:,2), 'LineWidth',2 ,'Color','red');

% 可修改参数进一步理解！！！



