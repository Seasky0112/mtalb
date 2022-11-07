%%%%%%%%%%%%%          4.0版本
%%%%%%%%%%%%%          均匀圆阵,完整版，包括水平、俯仰与三维

clear;
close all;
clc;
N = 36; %阵元数
c = 340;  %光速
f = 8000; %频率
lambda = c/f;
theta = linspace(0,pi,180);    %
phi = linspace(0,2*pi,360);
phi0 = 180; %角度
theta0 = 90;    %角度
phin = 2*pi/N;  %间隔

F1 = zeros(1,180*360);   %存储结果
ele=zeros(1,180*360);
azi=zeros(1,180*360);
m=1;
for ii = 1:360
    for jj = 1:180
        %坐标转换
        [x,y,z]=sph2cart(phi(ii),theta(jj),2);
        %求解声压
        F1(m)=abs(Transfer(0,0,0,x,y,z,8000));
        ele(m)=theta(jj);
        azi(m)=phi(ii);
        m=m+1;
    end
end
F1=F1/max(F1);
% ele
% azi

Ele=reshape(ele,[180 360]);
Azi=reshape(azi,[180 360]);
F1=reshape(F1,[180 360]);

[X,Y,Z]=sph2cart(Azi,Ele,F1);

mesh(X,Y,Z);
figure
surf(X,Y,Z);

% F1 = 20*log10(abs(F1)/max(max(abs(F1))));
% 
% plot(phi,F1(theta0*2+1,:));
% xlabel('水平角 \phi °');
% ylabel('增益大小 (dB)');
% title('圆阵DBF');
% xlim([0,360]);
% ylim([-25,0]);
% grid;
% 
% figure(2)
% plot(theta,F1(:,phi0));
% xlabel('俯仰角 \theta °');
% ylabel('增益大小 (dB)');
% title('圆阵DBF');
% xlim([0,180]);
% ylim([-25,0]);
% grid;
% 
% figure(3)
% mesh(phi,theta,F1)
% xlabel('水平角 \phi °');
% ylabel('俯仰角 \theta ° ');
% zlabel('增益大小 (dB)');
% title('圆环阵DBF三维视图');
