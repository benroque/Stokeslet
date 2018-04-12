clear;

%Initial Conditions
tFinal=10.0;
file=fopen('Magnetic_Free_IC.dat','r');
ICdat=fscanf(file,'%e');
fclose(file);
ICdat=transpose(ICdat);
dt=ICdat(1);
numpts=ICdat(2);
xIC=zeros(numpts);
yIC=zeros(numpts);
fx=zeros(numpts);
fy=zeros(numpts);
for i=1:numpts
    xIC(i)=ICdat(3+(4*(i-1)));
    yIC(i)=ICdat(4+(4*(i-1)));
    fx(i)=ICdat(5+(4*(i-1)));
    fy(i)=ICdat(6+(4*(i-1)));
end
tTot=int64(tFinal/dt);

foldername='dt'+string(dt)+'x';
for i=1:numpts
    foldername=foldername+string(xIC(i))+'-';
end

foldername=foldername+'y';
for i=1:numpts
    foldername=foldername+string(yIC(i))+'-';
end

foldername=foldername+'fx';
for i=1:numpts
    foldername=foldername+string(fx(i))+'-';
end

foldername=foldername+'fy';
for i=1:numpts
    foldername=foldername+string(fy(i))+'-';
end

    command = 'mkdir '+foldername;
    command = char(command);
    [status,result]=system(command);
    if(status==1)
        fprintf('Delete Data and Try again\n');
    end

%Solve for the fluid flow
for t=0:tTot
    t
    [status,result]=system('FreeFem++ Magnetic_Free.edp');
    newdat=updatePot(numpts,fx,fy,dt);
    try
        file = fopen('Data/newdat.dat','w');
    catch
        file = fopen('Data\newdat.dat','w');
    end
    for i=1:numpts
        fprintf(file,'%.20e \n',newdat(i,1));
        fprintf(file,'%.20e \n',newdat(i,2));
        fprintf(file,'%.20e \n',newdat(i,3));
        fprintf(file,'%.20e \n',newdat(i,4));
        fx(i)=newdat(i,3);
        fy(i)=newdat(i,4);
    end
    fclose(file);
end;
[status,result]=system('rm Data/u.dat Data/Jacobian.dat Data/curl.dat Data/newdat.dat');
if(status==1)
    %system('del Data\u.dat Data\Jacobian.dat Data\curl.dat Data\newdat.dat');
end