clc
clear 

%% 绘制出不同声源间距时的结果
[F,ACC,AE]=PM(0.1,10);
f1=figure;
semilogx(F,ACC,'r','DisplayName','D=0.1m');
hold on
f2=figure;
semilogx(F,AE,'r','DisplayName','D=0.1m');
hold on

[F,ACC,AE]=PM(0.2,10);
figure(f1) 
semilogx(F,ACC,'g','DisplayName','D=0.2m');
hold on
figure(f2)
semilogx(F,AE,'g','DisplayName','D=0.2m');
hold on

[F,ACC,AE]=PM(0.4,10);
figure(f1)
semilogx(F,ACC,'b','DisplayName','D=0.4m');
hold on
figure(f2)
semilogx(F,AE,'b','DisplayName','D=0.4m');
hold on

[F,ACC,AE]=PM(0.6,10);
figure(f1)
semilogx(F,ACC,'k--','DisplayName','D=0.6m');
hold on
figure(f2)
semilogx(F,AE,'k--','DisplayName','D=0.6m');
hold on

[F,ACC,AE]=PM(0.8,10);
figure(f1)
semilogx(F,ACC,'k-.','DisplayName','D=0.8m');
hold on
figure(f2)
semilogx(F,AE,'k-','DisplayName','D=0.8m');
hold on

[F,ACC,AE]=PM(1,10);
figure(f1)
semilogx(F,ACC,'k:','DisplayName','D=1m');
hold off
axis([100 10000 0 50])
legend
xlabel('Frequency,Hz')
ylabel('ContrastPerformance,dB')

figure(f2)
semilogx(F,AE,'k:','DisplayName','D=1m');
hold off
axis([100 10000 -20 60])
legend

xlabel('Frequency,Hz')
ylabel('Array Effort,dB')