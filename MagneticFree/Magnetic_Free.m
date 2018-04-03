clear;

%Initial Conditions
dt=0.01;
tFinal=100.0;
tTot=int64(tFinal/dt);

xIC=5.0;
yIC=5.0;
FxIC=0.0;
FyIC=-0.1;
fx=FxIC;
fy=FyIC;

%Write IC file
file = fopen('Magnetic_Free_IC.dat','w');
fprintf(file,'%.20e \n',dt);
fprintf(file,'%.20e \n',xIC);
fprintf(file,'%.20e \n',yIC);
fprintf(file,'%.20e \n',FxIC);
fprintf(file,'%.20e \n',FyIC);
fclose(file);

%Solve for the fluid flow
for t=0:tTot
    t
    [status,result]=system('FreeFem++ Magnetic_Free.edp');
    newdat=updatePot(fx,fy,dt);
    file = fopen('newdat.dat','w');
    fprintf(file,'%.20e \n',newdat(1));
    fprintf(file,'%.20e \n',newdat(2));
    fprintf(file,'%.20e \n',newdat(3));
    fprintf(file,'%.20e \n',newdat(4));
    fclose(file);
    fx=newdat(3);
    fy=newdat(4);
end;
[status,result]=system('rm u.dat Jacoabian.dat curl.dat newdat.dat');
if(status==1)
    system('del u.dat Jacobian.dat curl.dat newdat.dat');
end
