% 实验三 图像增强

%% 基于直方图的图像增强
% clear,clc;  % 清除变量
% filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
% I = imread(filename);  % 读取图片
% imshow(I);  % 显示图片

%% 图像空间域平滑
% 读入图像并加入噪声
clear,clc;  % 清除变量
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);
J = imnoise(I,'salt & pepper', 0.05);  % 在图像I中加入0.05的椒盐噪声
K = imnoise(I, 'gaussian', 0.01, 0.02);  % 在图像在图像中加入均值为0.01、方差为0.02的高斯噪声。
% subplot(1,3,1), imshow(I); title('原图');
% subplot(1,3,2), imshow(J); title('椒盐噪声图');
% subplot(1,3,3), imshow(K); title('高斯噪声图');

% 椒盐噪声在不投邻域值下的滤波均值
h1 = ones(3,3)/9;  % 3×3窗口
J1 = imfilter(J, h1);
h2 = ones(7,7)/9;  % 7×7窗口
J2 = imfilter(J, h2);
% subplot(1,3,1), imshow(J); title('椒盐噪声图');
% subplot(1,3,2), imshow(J1); title('3×3窗口均值滤波');
% subplot(1,3,3), imshow(J2); title('7×7窗口均值滤波');

% 对高斯噪声进行均值、中值滤波
h = ones(5,5)/25;  % 3×3窗口
K1 = imfilter(K, h);  % 均值滤波
K2 = medfilt2(K);  % 中值滤波
subplot(1,3,1), imshow(J); title('高斯噪声图');
subplot(1,3,2), imshow(J1); title('5×5窗口均值滤波图');
subplot(1,3,3), imshow(J2); title('中值滤波图');


%% 图像空间域锐化
% 利用算子锐化图像
clear,clc;  % 清除变量
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
% I = rgb2gray(I);  % RGB转灰度图像
hx = [-1 -2 -1; 0 0 0; 1 2 1];  %创建Sobel垂直梯度模板
hy = hx';
gradx = imfilter(I,hx);  % 计算图像的Sobel垂直梯度
grady = imfilter(I,hy);  % 计算图像的Sobel水平梯度
grad = gradx.^2 + grady.^2;  % 得到图像的Sobel梯度
subplot(221), imshow(I); title('原始图');
subplot(222), imshow(gradx); title('图像的sobel垂直梯度');
subplot(223), imshow(grady); title('图像的sobel水平梯度');
subplot(224), imshow(grad); title('图像的sobel梯度');

% 利用fspecial函数生成各种梯度算子
h = fspecial(''sobel)


%% 图像频率域平滑与锐化

