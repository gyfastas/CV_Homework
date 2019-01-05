
s = 0:0.01:2;
ps = 2*(sqrt(s+1)-1);

subplot(121);
plot(s,ps);
title('º¯ÊýÍ¼Ïñ2');

dps = (ps(2:end)-ps(1:end-1))/0.01;
s =  s(2:end);
subplot(122);
plot(s,dps);
title('µ¼ÊýÍ¼Ïñ2');