% 实验四 图像复原

%% 几种复原函数
% deconvwnr:维纳滤波复原
% deconvreg:约束最小二乘复原
% deconvblind:使用盲解卷积恢复
% fspecial : 创建指定类型的二维滤波器

%% 例子：维纳滤波复原
f = checkerboard(8);  % 棋盘图像
subplot(221), imshow(f),title('原始图像');
PSF = fspecial('motion',7,45);  % 生成点扩散函数
gb = imfilter(f,PSF, 'circular');
noise = imnoise(zeros(size(f)), 'gaussian', 0, 0.001);  % 噪声
g = gb + noise;  % 加上噪声后的图像
subplot(222); imshow(g);title('退化图像');
Sn = abs(fft2(noise)).^2;  % 计算噪声功谱率
Sf = abs(fft2(f)).^2;  % 计算图像功谱率
NCORR = fftshift(real(ifft2(Sn)));  % 噪声的自相关系数
ICORR = fftshift(real(ifft2(Sf)));  % 原图像的自相关系数
fr = deconvwnr(g, PSF, NCORR, ICORR);
subplot(223); imshow(fr); title('维纳滤波图像');

%% 傅里叶变换还需要好好理解