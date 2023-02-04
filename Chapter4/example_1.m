%实验一 遥感图像读写

clear, clc, close all;

%% 1.遥感图像头文件的读取
hdrfilename = 'can_tmr/can_tmr.hdr';
fid = fopen(hdrfilename, 'r');
info = fread(fid, 'char=>char');
info = info';  % 转置为行向量显示
fprintf('%s\n', info); % 界面打印输出显示
fclose(fid);

%% 遥感影像的基本信息读取
% 读取列数、行数、波段数、数据类型
% 列数
ac = strfind(info, 'samples = ');  % 'samples = '在info中的位置
bc = length('samples = ');  % 字符串长度
cc = strfind(info, 'lines');  % ...位置
samples = [];
for i = ac+bc : cc-1
    samples = [samples, info(i)];
end
samples = str2num(samples);

% 列数
ar = strfind(info, 'lines   = ');  % 'lines = '在info中的位置  3个空格
br = length('lines   = ');  % 字符串长度
cr = strfind(info, 'bands   ');  % ...位置
lines = [];
for i = ar+br : cr-1
    lines = [lines, info(i)];
end
lines = str2num(lines);

% 波段数
ab = strfind(info, 'bands   = ');  % 'lines = '在info中的位置  3个空格
bb = length('bands   = ');  % 字符串长度
cb = strfind(info, 'header offset');  % ...位置
bands = [];
for i = ab+bb : cb-1
    bands = [bands, info(i)];
end
bands = str2num(bands);

% 数据类型
at = strfind(info, 'data type = ');
bt = length('data type = ');
ct = strfind(info, 'interleave');
datatype = [];
for i = at + bt:ct-1
    datatype = [datatype, info(i)];
end
datatype = str2num(datatype);
precision = [];
switch datatype
    case 1
        precision = 'uint8=>uint8';  % 对应关系
    case 2
        precision = 'int16=>int8';
    case 12
        precision = 'uint16=>uint16';
    case 3
        precision = 'int32=>int32';
    case 13
        precision = 'uint32=>uint32';
    case 4
        precision = 'float32=>float32';
    case 5
        precision = 'double=>double';
    otherwise
        error('invalid datatype');
        % 除以上几种常见数据类型之外的数据类型视为无效数据类型
end

% 数据格式
ai = strfind(info, 'interleave = ');
bi = length('interleave = ');
ci = strfind(info, 'sensor type');
interleave = [];
for i = ai + bi:ci-1
    interleave = [interleave, info(i)];
end
interleave = strtrim(interleave);

% 输出
fprintf('Lines = %i\nSamples = %i\nDataType = %s\n', lines,samples,interleave);

%% 遥感图像数据读取与显示
% 读取数据
imgfilename = 'can_tmr/can_tmr.img';  % 路径
fid = fopen(imgfilename, 'r');
% 写代码时候uint输成unit,错误！！！
data = multibandread(imgfilename, [lines, samples, bands], precision, 0, interleave, 'ieee-le');
data = double(data); 
% 数值转为0-255的整型用于显示
data_show = data;
for k = 1:bands
    min_val = min(data_show(:, :, k));  % 第k个波段的最小值
    max_val = max(data_show(:, :, k));  % 最大值
    % 逐个像元pixel遍历
    for i = 1:lines  % 行
        for j = 1:samples  % 列
            % 将像素值归一化后再乘255，所有像元值都大于0小于255了
            data_show(i,j,k) = uint8((data_show(i,j,k) - min_val) / (max_val - min_val) * 255 );
        end
    end
end
% 单波段遥感图像显示
numArray = bands;
for i = 1 : numArray
    % eval自动命名变量
    eval(['im', num2str(i), '=', 'uint8(data_show(:, :, i))',';']);
end

subplot(231), imshow(im1);title('B1');
subplot(232), imshow(im2);title('B2');
subplot(233), imshow(im3);title('B3');
subplot(234), imshow(im4);title('B4');
subplot(235), imshow(im5);title('B5');
subplot(236), imshow(im6);title('B7');

% 真彩色显示
imtrclr = uint8(data_show(:, :, [3 2 1]));
figure(); imshow(imtrclr); title('真彩色显示');

% 假彩色显示
imflsclr = uint8(data_show(:, :, [4, 2, 1]));
figure(); imshow(imflsclr); title('假彩色显示');


%% 遥感数据图像数据存储
% 以BIL存储类型存储多波段数据
multibandwrite(imflsclr, 'imflsclr.bil', 'bil');

% 以存储32bit单波段为例
numBands = 1;
for band = 1:numBands
    multibandwrite(data(:,:,band), 'banddata.bsq', 'bsq');
end




