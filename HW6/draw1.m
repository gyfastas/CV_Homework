%画出p(s)的导数图

s1 = 0:0.02:1;
s2 = 1:0.02:2;
p_s1 = s1;
p_s2 = sqrt(2*s2.*s2-1);
s = [s1,s2];
p_s = [p_s1,p_s2];
subplot(121);
plot(s,p_s);
title('函数曲线1');

dps = p_s(2:end)-p_s(1:end-1);
ds = s(2:end);
dps(dps==0) = 0.02;
dps = dps/0.02;
subplot(122);
scatter(ds,dps,'filled');
axis([0 2  0 2]);
title('导数曲线1');