% 程序设计基础
% easy

%% 函数
% function 输出形参表 = 参数名(输入形参表) 
%           注释说明部分
%           函数体
%   [输出实参表] = 函数名(输入实参表)


%% 文件操作
% 文件打开
% fid = fopen(文件名, '打开方式') r r+ w w+ a a+ W A
% 关闭文件
% sta = fclose(fid)

% 二进制文件(.bin)
% fread fwrite
% a = [1 2 3 4 5 6 7 8 9];
% fid = fopen('E:\MyCode\Matlab\MATLAB遥感数字图像处理_实践教程\Chapter1\test.bin', 'wb');  % 3表示打开成功
% fwrite(fid, a, 'double');  % ans值表示写入数据个数
% fclose(fid);  % ans = 0表示关闭成功

% 文本文件(.txt)
% fscanf fprint

% 文件定位fseek

%% MATLAB程序设计结构
% 顺序、循环、选择、其他
