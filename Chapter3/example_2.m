% 实验二 数字图像的傅里叶变换

clear,clc;  % 清除变量
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\haha.jpg";
I = imread(filename);  % 读入RGB图像
I = rgb2gray(I);  % RGB转灰度图像
j = fft2(I);  % 进行傅里叶变换
k = fftshift(j);
L = log(1 + abs(k));  % 对数变换，增强灰度级的细节
subplot(121), imshow(I);  % 原始图像
subplot(122), imshow(L, []);  % 显示傅里叶变换图像