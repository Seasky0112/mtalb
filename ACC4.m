function [F,ACC,AE]=ACC4(D,df)
%[F,AE,ACC]=ACC4(D,df),声场采样点为波长的1/2
% D=0.4;  %声源x间距
f0=100;   %声源起始频率
fe=10000;   %声源终止频率
ds=0.1;  %声源间隔

% c=340;  %声速

% K=8;    %声源个数
len=3;  %空间尺寸
wid=1.8;
hei=1.3;

%% 控制声场区域
brightx=[1 1.2];
brighty=[0.2 1.6];
brightz=[0.8 1];

darkx=[2 2.2];
darky=brighty;
darkz=brightz;

%% 生成声源和控制点坐标，并构造向量

%声源坐标
x1=(brightx(1)+0.1+(darkx(1)+0.1))/2-D/2;
xs=[x1 x1 x1 x1 x1+D x1+D x1+D x1+D];   %声源x坐标向量
y1=wid/2-ds/2-ds;
ys=[y1 y1+ds y1+2*ds y1+3*ds y1 y1+ds y1+2*ds y1+3*ds]; %声源y坐标向量
zs=ones(1,8)*1.3;   %声源z坐标向量
nf=length(f0:df:fe);
F=zeros(nf,1);  %存储频率向量
ACC=zeros(nf,1);  %存储声学对比度向量
AE=zeros(nf,1); %存储Array Effort
m=1;



for f=f0:df:fe

    dp=340/f/2;    %声场采样点间隔
    
    x = 1:dp:1.2;
    y = 0.2:dp:1.6;
    z = 0.8:dp:1;
    Ny=length(x);    
    Nx=length(y);
    Nz=length(z);
    if Nx*Ny*Nz<20
        dp=0.2;
        x = 1:dp:1.2;
        y = 0.2:dp:1.6;
        z = 0.8:dp:1;
    end

    %生成坐标矩阵
    [Xb,Yb,Zb] = meshgrid(x,y,z);   %亮区
    x=2:dp:2.2;
    [Xd,Yd,Zd] = meshgrid(x,y,z);   %暗区
    
    %声亮区坐标向量
    Xb=reshape(Xb,[],1);
    Yb=reshape(Yb,[],1);
    Zb=reshape(Zb,[],1);
    %声暗区坐标向量
    Xd=reshape(Xd,[],1);
    Yd=reshape(Yd,[],1);
    Zd=reshape(Zd,[],1);
    
    %% 求格林函数矩阵
    %亮区格林矩阵
    Gb=zeros(length(Xb),length(zs));
    
    for i=1:length(Xb)
        for j=1:length(zs)
            Gb(i,j)=Green(xs(j),ys(j),zs(j),Xb(i),Yb(i),Zb(i),f);
        end
    end
    
    Rb=Gb'*Gb;%亮区空间相关矩阵
  
    %暗区格林矩阵
    Gd=zeros(length(Xd),length(zs));
    for i=1:length(Xd)
        for j=1:length(zs)
            Gd(i,j)=Green(xs(j),ys(j),zs(j),Xd(i),Yd(i),Zd(i),f);
        end
    end
    
    Rd=Gd'*Gd;  %和暗区空间相关矩阵
    
    %% 求解激励向量
    q0=[0.5 0.5 0.5 0.5 0 0 0 0]';  %目标声场声源输入向量
    E0=q0'*Rb*q0;   %目标声场能量

    %不控制信号源激励，lambda2=0

    M=inv(Rd)*Rb;
    [V,E] = eig(M);
    T=M*V-V*E;  %特征向量构成的矩阵
    eigen = diag(E);    %特征值构成的向量
    [eigenmax,I]=max(eigen);    %最大特征值
    q=(V(:,I));     %最大特征值对应的特征向量

    lamb_2=E0/(q'*Rb*q);    %该系数控制控制声源输入向量，使亮区的能量符合预期声场
    
    F(m)=f;
    AE(m)=10*log10(lamb_2*(q'*q));   %Array Effort
    ACC(m)=10*log10((q'*Rb*q)/(q'*Rd*q));    %声学对比度
    m=m+1;
    [num2str((f-f0)/(fe-f0)*100) '%']

end


%% 格林函数
function output=Green(xc,yc,zc,xm,ym,zm,f)
%格林函数Green(xc,yc,zc,xm,ym,zm,f)

    k=2*pi*f/340;   %波数
    C=(-1i*1.29*2*pi*f)/(4*pi);
    R=sqrt((xc-xm)^2+(yc-ym)^2+(zc-zm)^2);    %两点间距离
    output=C*exp(1i*k*R)/R;
end


end