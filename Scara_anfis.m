hold on;
 i=1;d1=100;d5=20;
 a2=20; a3=30;
for th1=0:0.01:pi/2
for th2=0:0.1:pi/6
for d3=0:0.1:20 

                    
X(i)=a2*cos(th1 + th2) + a3*cos(th1 + th2);
Y(i)=a2*sin(th1 + th2) + a3*sin(th1 + th2);
Z(i)=d1 - d3 - d5;
tht1(i)=th1;
tht2(i)=th2;
d(i)=d3;
i=i+1;

end
end
end


data1=[X' Y' Z' tht1'];
data2=[X' Y' Z' tht2'];
data3=[X' Y' Z' d'];

plot3(X', Y', Z', 'r.');

numMFs=3;
mfType='gaussmf';

in_fis1=genfis1(data1,numMFs,mfType);
in_fis2=genfis1(data2,numMFs,mfType);
in_fis3=genfis1(data3,numMFs,mfType);


anfis1=anfis(data1,in_fis1,10,[0,0,0,0]);
anfis2=anfis(data2,in_fis2,10,[0,0,0,0]);
anfis3=anfis(data3,in_fis3,10,[0,0,0,0]);

a=50;b=25/pi;
k=1;
for t=pi/2:-0.1:0

x=a*cos(t);
y=a*sin(t);
z=65 + b*t;
xx(k)=x;
yy(k)=y;
zz(k)=z;
XYZ=[x y z];

th1p=evalfis(XYZ, anfis1);
th2p=evalfis(XYZ, anfis2);
dp=evalfis(XYZ, anfis3);

x1p=0;
y1p=0;
z1p=0;
x2p=0;
y2p=0;
z2p=d1;
x3p=a2*cos(th1p+th2p);
y3p=a2*sin(th1p+th2p);
z3p=d1;
x4p=(a2+a3)*cos(th1p+th2p);
y4p=(a2+a3)*sin(th1p+th2p);
z4p=d1;
x5p=(a2+a3)*cos(th1p+th2p);
y5p=(a2+a3)*sin(th1p+th2p);
z5p=d1-dp-d5;

plot3([x1p,x2p,x3p,x4p,x5p],[y1p,y2p,y3p,y4p,y5p],[z1p,z2p,z3p,z4p,z5p],'b');
X1(k)=(a2+a3)*cos(th1p+th2p);
Y1(k)=(a2+a3)*sin(th1p+th2p);
Z1(k)=d1-dp-d5;
k=k+1;
end
plot3(xx',yy',zz','k');
plot3(X1',Y1',Z1','*b');

