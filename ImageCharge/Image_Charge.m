clear;

%Initial Conditions
dt=0.1;
tFinal=10.0;
tTot = int64(tFinal/dt);

xIC=0.5;
yIC=0.5;
FIC=0.1;

%Write IC file
file = fopen('Image_Charge_IC.dat','w');
fprintf(file,'%.20e \n',dt);
fprintf(file,'%.20e \n',xIC);
fprintf(file,'%.20e \n',yIC);
fprintf(file,'%.20e \n',FIC);
fclose(file);

%Solve time step by time step
for t=0:tTot
    [status,result]=system('FreeFem++ Image_Charge2.edp');
    newdat=updatePot(dt);
    file = fopen('newdat.dat','w');
    fprintf(file,'%.20e \n',newdat(1));
    fprintf(file,'%.20e \n',newdat(2));
    fclose(file);
end

fprintf('Job Done \n');