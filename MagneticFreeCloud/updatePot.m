%Take data from FreeFem++ and find next time step
function newdat=updatePot(numpts,fx,fy,dt);
    try
        urawdat=importdata('Data/u.dat');
        jacobrawdat=importdata('Data/Jacobian.dat');
    catch
        urawdat=importdata('Data\u.dat');
        jacobrawdat=importdata('Data\Jacobian.dat');
    end
    u=transpose(urawdat);
    RHS=zeros(numpts,2);
    newF=zeros(numpts,2);
    for i=1:numpts
        Jacob=[jacobrawdat(i,1) jacobrawdat(i,2); jacobrawdat(i,3) jacobrawdat(i,4)];
        identity=[1 0; 0 1];
        LHSOp=identity-(Jacob*dt/2);
        newF(i)=updateF(i,fx(i),fy(i));
        RHSOp=(-newF/(6*pi)+u);
        RHS(i)=dt*(RHSOp)*inv(LHSOp);
    end
    newdat=[RHS(1) RHS(2) newF(1) newF(2)];
end