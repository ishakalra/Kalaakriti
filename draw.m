function I=draw(I,m,n)
global wrist; % elbow shoulder;
   display(m);
   display(n);
   r=size(I);
   reach(4+n,4+m);
   writePosition(wrist,double(91)/180);
   pause(0.01);
   I(m,n)=0;
      for i=m-1:1:m+1
          for j=n-1:1:n+1
              if i>0 && i<=r(1,1) && j>0 && j<=r(1,2) && I(i,j)==1 && (i~=m || j~=n)
                writePosition(wrist,double(91)/180);
                pause(0.01);
                I=draw(I,i,j);
                reach(4+n,4+m);
                pause(0.01);
              end
          end
      end
     writePosition(wrist,double(60)/180);
     pause(0.01);
end

function reach(x,y)

e=rnd(calce(x,y));
s=rnd(calcs(x,y));

move_to(e,s);

end

function move_to(e,s)
global S E shoulder elbow;

if abs(E-e)>0.5
    while E~=e
        if abs(S-s)>0.5
            if S<s
                S=S+0.5;
            else
                S=S-0.5;
            end
            writePosition(shoulder,double(S)/180);
        end
        if E<e
            E=E+0.5;
        else
            E=E-0.5;
        end
        writePosition(elbow,double(E)/180);
        pause(0.01);
    end
else
    E=e;
    writePosition(elbow,double(E)/180);
    pause(0.01);
end

if abs(S-s)>0.5
    while S~=s
        if S<s
            S=S+0.5;
        else
            S=S-0.5;
        end
            writePosition(shoulder,double(S)/180);
        pause(0.01);
    end
else
    S=s;
    writePosition(shoulder,double(S)/180);
    pause(0.01);
end
end

function x1=rnd(x)
x=x*2;
x1=int16(x);
x1=double(x1)/2;
end

function e=calce(x,y)
e=180*1.0/pi*2*acos(sqrt(x*x+y*y)*1.0/40);
end

function s=calcs(x,y)
s=180*1.0/pi*(atan(y/x)+acos(sqrt(x*x+y*y)*1.0/40));
end
