clear;

%Initial Conditions
dt=0.001;
tFinal=1.0;
tTot=int64(tFinal/dt);

xIC=5.0;
yIC=5.0;
FxIC=0.0;
FyIC=-1.0;
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
