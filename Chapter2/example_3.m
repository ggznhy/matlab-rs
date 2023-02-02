% MATLAB程序设计

% 打印文字并保存
s = 'Hello World';
fid = fopen('hw.txt','w+');
fprintf(fid,'%s',s);
