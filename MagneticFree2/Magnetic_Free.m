clear;

%Initial Conditions
tFinal=10.0;
tTot=int64(tFinal/dt);

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