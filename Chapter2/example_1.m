% 实验一 MATLAB基本操作

% 4)绘制图像
x = [0 : 0.01 : 2*pi];
y = 2 * exp(-5*x) .* sin(2*pi*x);
plot(x,y,'r-.');
title('二维函数图像');
legend('y');
xlabel('x');ylabel('y');