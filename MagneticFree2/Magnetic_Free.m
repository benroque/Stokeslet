clear;

%Initial Conditions
tFinal=100.0;
file=fopen('Magnetic_Free_IC.dat','r');
ICdat=fscanf(file,'%e');
fclose(file);
ICdat=transpose(ICdat);
dt=ICdat(1);
xIC=ICdat(2);
yIC=ICdat(3);
fx=ICdat(4);
fy=ICdat(5);
tTot=int64(tFinal/dt);

foldername='dt'+string(dt)+'x'+string(xIC)+'y'+string(yIC)+'fx'+string(fx)+'fy'+string(fy);
    command = 'mkdir '+foldername;
    command = char(command);
    [status,result]=system(command);
    if(status==1)
        fprintf('Delete Data and Try again\n');
    end

%Solve for the fluid flow
for t=0:tTot
    [status,result]=system('FreeFem++ Magnetic_Free.edp');
    newdat=updatePot(fx,fy,dt);
    try
        file = fopen('Data/newdat.dat','w');
    catch
        file = fopen('Data\newdat.dat','w');
    end
    fprintf(file,'%.20e \n',newdat(1));
    fprintf(file,'%.20e \n',newdat(2));
    fprintf(file,'%.20e \n',newdat(3));
    fprintf(file,'%.20e \n',newdat(4));
    fclose(file);
    fx=newdat(3);
    fy=newdat(4);
end;
[status,result]=system('rm Data/u.dat Data/Jacobian.dat Data/curl.dat Data/newdat.dat');
if(status==1)
    %system('del Data\u.dat Data\Jacobian.dat Data\curl.dat Data\newdat.dat');
end