clc
clear 

%% 绘制出不同声源间距时的结果，频率步长50Hz，声场采样点间隔0.01m
[F,A]=PM(0.1,50);
semilogx(F,A,'r','DisplayName','D=0.1m');
hold on
[F,A]=PM(0.2,50);
semilogx(F,A,'g','DisplayName','D=0.2m');
hold on
[F,A]=PM(0.4,50);
semilogx(F,A,'b','DisplayName','D=0.4m');
hold on
[F,A]=PM(0.6,50);
semilogx(F,A,'k--','DisplayName','D=0.6m');
hold on
[F,A]=PM(0.8,50);
semilogx(F,A,'k-.','DisplayName','D=0.8m');
hold on
[F,A]=PM(1,50);
semilogx(F,A,'k:','DisplayName','D=1m');
hold off
axis([100 10000 0 50])
legend



xlabel('Frequency,Hz')
ylabel('ContrastPerformance,dB')