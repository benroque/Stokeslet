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
    t
    [status,result]=system('FreeFem++ Image_Charge2.edp');
    newdat=updatePot(dt);
    file = fopen('newdat.dat','w');
    fprintf(file,'%.20e \n',newdat(1));
    fprintf(file,'%.20e \n',newdat(2));
    fclose(file);
end;

%Plot final position data
posDat = importdata('Pos.dat');
[status,result] = system('rm Pos.dat');
    %Windows Fix for Unix code above
    if (status == 1)
        system('del Pos.dat');
    end
plot(posDat(:,2))

%Take data from FreeFem++ and find next time step
function RHS=updatePot(dt)
    rawdat=importdata('LHSOp.dat');
    dat = rawdat.data;
    dat = dat([2:end],[1:3]);
    LHSOp = zeros(2);
    for d = 1:4
        LHSOp(dat(d,1),dat(d,2))=dat(d,3);
    end
    RHS=dt*inv(LHSOp)*importdata('RHSOp.dat').';
    [status,result] = system('rm LHSOp.dat && rm RHSOp.dat');
    %Windows Fix for Unix code above
    if (status == 1)
        system('del LHSOp.dat && del RHSOp.dat');
    end
end
