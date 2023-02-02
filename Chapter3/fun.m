function fx = fun(x)
%FUN 此处显示有关此函数的摘要
%   简单分段函数
if x>1
    fx = x^2;
elseif x<=1 && x>-1
    fx = 1;
elseif x<=-1
    fx = 3+2*x;
end
end

