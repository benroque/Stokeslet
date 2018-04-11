clear;

%Initial Conditions
tFinal=0.1;
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
    xIC(i)=ICdat(2+(4*(i-1)));
    yIC(i)=ICdat(3+(4*(i-1)));
    fx(i)=ICdat(4+(4*(i-1)));
    fy(i)=ICdat(5+(4*(i-1)));
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
    [status,result]=system('FreeFem++ Magnetic_Free.edp');
    newdat=updatePot(fx,fy,dt);
    try
        file = fopen('Data/newdat.dat','w');
    catch
        file = fopen('Data\newdat.dat','w');
    end
    for i=1:numpts
        fprintf(file,'%.20e \n',newdat(1,i));
        fprintf(file,'%.20e \n',newdat(2,i));
        fprintf(file,'%.20e \n',newdat(3,i));
        fprintf(file,'%.20e \n',newdat(4,i));
        fclose(file);
        fx(i)=newdat(3,i);
        fy(i)=newdat(4,i);
    end
end;
[status,result]=system('rm Data/u.dat Data/Jacobian.dat Data/curl.dat Data/newdat.dat');
if(status==1)
    %system('del Data\u.dat Data\Jacobian.dat Data\curl.dat Data\newdat.dat');
end