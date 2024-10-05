function geom
clc;
clear all;
close all;
data=load('data_pointmass.txt');
tData=data(:,1);
wData=data(:,2);
mData=wData/9.81;
dData=data(:,3);
yData=data(:,4);
lData=data(:,5);
trData=data(:,6);
alphaData=data(:,7);
betaData=data(:,8);
miuData=data(:,9);
phiT=0;
IC=load('IC_pointmass.txt');
tspan=1.0000000e-02:1.000000e-02:2.0000000e+01;
[t,x]=ode45(@(t,x) odefunc(t,x,tData,wData,mData,dData,yData,lData,trData,alphaData,betaData,miuData),tspan,IC);
figure;
plot(tData,alphaData,'black','linewid',2)
title('angle of attack over time');
ylabel('angle of attack (rad)');
xlabel('time (s)'); 
figure;
plot(tData,betaData,'black','linewid',2);
title('beta angle over time');
ylabel('beta angle (rad)'); 
xlabel('time (s)');
figure;
plot(tData,miuData,'black','linewid',2);
title('miu angle over time');
ylabel('miu angle (rad)') ;
xlabel('time (s)');
figure;
plot(t,x(:,1),'black','linewid',2);
title('v over time');
ylabel('v (m/s)') ;
xlabel('time (s)');
figure;
plot(t,x(:,2),'black','linewid',2);
title('sai over time');
ylabel('sai (m/s)') ;
xlabel('time (s)');
figure;
plot(t,x(:,3),'black','linewid',2);
title('gama over time');
ylabel('gama (m/s)');
xlabel('time (s)');
figure;
plot(t,x(:,4),'black','linewid',2);
title('x over time');
ylabel('x (m)'); 
xlabel('time (s)');
figure;
plot(t,x(:,5),'black','linewid',2);
title('y over time');
ylabel('y (m)'); 
xlabel('time (s)');
figure;
plot(t,x(:,6),'black','linewid',2);
title('z over time');
ylabel('z (m)'); 
xlabel('time (s)');
function dxdt=odefunc(t,x,tData,wData,mData,dData,yData,lData,trData,alphaData,betaData,miuData)
W=interp1(tData,wData,t);
m=interp1(tData,mData,t);
D=interp1(tData,dData,t);
T=interp1(tData,trData,t);
alpha=interp1(tData,alphaData,t);
beta=interp1(tData,betaData,t);
Y=interp1(tData,yData,t);
L=interp1(tData,lData,t);
miu=interp1(tData,miuData,t);
dxdt=zeros(6,1);
dxdt(1) = (1/m)*(-W*sin(x(3))-D+(T*cos(beta)*cos(alpha+phiT)));
dxdt(2) = (1/(m*x(1)*cos(x(3))))*((-Y*cos(miu))+(L*sin(miu))-T*((cos(alpha+phiT)*sin(beta)*cos(miu))-(sin(alpha+phiT)*sin(miu))));
dxdt(3) = (1/(m*x(1)))*((-W*cos(x(3)))-(Y*sin(miu))+(L*cos(miu))+T*((cos(alpha+phiT)*sin(beta)*sin(miu))+(sin(alpha+phiT)*cos(miu))));
dxdt(4)=x(1)*cos(x(2))*cos(x(3));
dxdt(5)=x(1)*sin(x(2))*cos(x(3));
dxdt(6)=-x(1)*cos(x(3));
end
end
