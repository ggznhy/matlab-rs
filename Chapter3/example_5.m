% 实验五 图像编码压缩

%% MATLAB中相关函数 灰度图像
% dct2 二维离散余弦
% idct2 二维离散余弦反变换
% dctmtx 计算DCT变换矩阵
% blkproc 对图像进行分块处理

%% 例1
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);
I1 = im2double(I);
T = dct2(I1);
T1 = T;
T1(1,1) = 0;  % 去除原点值
I2 = idct2(T1);  % 对该图像进行离散余弦反变换
% 显示
subplot(121), imshow(I);
subplot(122), imshow(I2);


%% 例2
clc;clear all; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\hzwz.jpeg";  % 图片绝对路径
I = imread(filename);  % 读取图片
I = rgb2gray(I);
I = im2double(I);
T = dctmtx(8);  % 离散余弦变换矩阵
B = blkproc(I, [8 8], 'P1 * x * P2', T, T');  % 对源图像进行DCT变换
mask = [1 1 1 0 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 1 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];
 B2 = blkproc(B, [8 8], 'P1.*x', mask);  % 数据压缩，丢弃右下角高频数据
 I2 = blkproc(I, [8 8], 'P1 * x * P2', T', T);  % 进行反DCT变换
 
 figure;  % 新开一个图形窗口
 subplot(121); imshow(I, []);
 subplot(122); imshow(I2, []);


