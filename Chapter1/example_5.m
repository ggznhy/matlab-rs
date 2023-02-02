% MATLAB图像处理工具箱（重点）

%% 基本的图像处理函数
% 读图像
% A = imread(filename, fmt);  % A 影像数据阵列
% [X， Map] = imread(filename, fmt); % X:图像数据， Map:相关的色彩
% 例1
clear;  % 清除变量
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter1\haha.jpg";
f = imread(filename);

% 显示图像
% imshow(f)
% imshow(f, [64, 128])
% 例2
subplot(121),imshow(f);
subplot(122),imshow(f, [64, 128]);

% 检查图像矩阵的其他信息
whos f

% 读取图像的详细信息
imfinfo(filename);

% 保存图像
filename1 =  "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter1\haha.bmp";
imwrite(f, filename1);

%% MATLAB所支持的图像类型
% 1）真彩色 RGB 24位  m×n×3
% 2）索引图像[X, Map]
% 3) 灰度图像 0-255
% 4）二值图像 0、1


%% OK