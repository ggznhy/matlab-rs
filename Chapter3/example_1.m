% 实验一 MATLAB图像处理基础

%% 文件操作

% 1)建立数据文件test.dat,用于存放矩阵A的数据
A = [1 2 3; 4 5 6; 7 8 9];
fid = fopen('test.dat','w');
cnt = fwrite(fid, A, 'float');
fclose(fid)

% 2）读取文件test.dat的内容
fid = fopen('test.dat','r');
[B, cnt] = fread(fid,[5, inf],'float');  % 读取格式为5行
fclose(fid);

% 3）文件定位
% 写
a = 1:5;
fid = fopen('fdat.txt','w');
fwrite(fid, a,'int16');
status1 = fclose(fid);
% 读
fid = fopen('fdat.txt','r');
status2 = fseek(fid,6,'bof');  % 将文件指针从开始位置向尾部偏移6个字节
four = fread(fid,1,'int16');
position = ftell(fid);
eight = fread(fid,1,'int16');


%% 图像基本操作
% 1）读入并显示一副图像
clear;
close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\haha.jpg"
I = imread(filename);
imshow(I)

% 2）对图像进行一些基本操作
clear; close all;
filename = "E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter3\haha.jpg";
I = imread(filename);  % 读取
I1 = imresize(I,0.5);  % 图像缩小为原来的一半
I2 = rgb2gray(I);  % 将彩色图像转为灰色图像
I3 = imrotate(I, 45);  % 旋转45°，逆时针
figure
subplot(221);imshow(I);
subplot(222);imshow(I1);
subplot(223);imshow(I2);
subplot(224);imshow(I3);

%% 编程
clear;clc;
y = fun(10);
y

