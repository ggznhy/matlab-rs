% 绘图
clear; clc;

%% 图形窗口
% axis 命令，设置坐标轴
% axis([1 10, 2 18])

% 刻度设置
% set(gca,'Xtick',xs, 'Ytick', ys, 'Ztick', zs)  % gca是句柄

% 分格线
% gird off;
% gird on;

% 图形标识
% title('graphic example');
% xlabel('x'); ylabel('y');
% legend('s1','s2');
% text(x, y, 's')  % 注释

% 绘图控制
% figure(n)  % 打开第n个图形窗口
% clf  % 情况图形窗口
% hold on  % 绘图保持
% hold off  % 取消绘图保持
% subplot(mmk)  % 将图形窗口分成m*n个子图，在第k个子图上绘图

%% 二维绘图命令
x = [0 : 0.01 : 2*pi];
y1 = linspace(0, 0, length(x))
y2 = sin(x);
% plot(x, y1);
% plot(x, y2);
plot(x,y1,'r:', x, y2, 'b-')

%% 三维绘图命令

% plot3()

%% 其他绘图命令
% bar stairs stem fill scatter bar3 pie3 fill3 contour contour3



