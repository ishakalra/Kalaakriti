clc
close all
clear all;

u=imread('Cloud.png');
s=size(u);
display(s);
I=rgb2gray(u);
for i=1:1:20
    for j=1:1:20
        if(I(i,j)>200)
            I(i,j)=1;
        end
    end
end
I=flip(I,1);
display(I);

global a;
a = arduino();
global elbow shoulder wrist;
elbow=servo(a,7,'MinPulseDuration',5.44e-4,'MaxPulseDuration',2.079e-3);
shoulder=servo(a,4,'MinPulseDuration',5.44e-4,'MaxPulseDuration',2.160e-3);
wrist=servo(a,8);
writePosition(wrist,60/180);
pause(0.4);
writePosition(elbow,0/180);
pause(0.4);
writePosition(shoulder,90/180);
pause(0.4);
global S E;
S=90;
E=0;
pause(0.1);
e=size(I);
for p=1:1:e(1,1)
    for t=1:1:e(1,2)
       if I(p,t)==1
           display(p);
           display(t);
           I=draw(I,p,t);
       end
    end
end
clear a;