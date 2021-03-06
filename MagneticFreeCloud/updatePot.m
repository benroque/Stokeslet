%Take data from FreeFem++ and find next time step
function newdat=updatePot(numpts,fx,fy,dt);
    try
        urawdat=importdata('Data/u.dat');
        jacobrawdat=importdata('Data/Jacobian.dat');
    catch
        urawdat=importdata('Data\u.dat');
        jacobrawdat=importdata('Data\Jacobian.dat');
    end
    uraw=transpose(urawdat);
    RHS=zeros(numpts,2);
    newF=zeros(numpts,2);
    for i=1:numpts
        Jacob=[jacobrawdat(4*(i-1)+1) jacobrawdat(4*(i-1)+2); jacobrawdat(4*(i-1)+3) jacobrawdat(4*(i-1)+4)];
        u=[uraw(2*(i-1)+1) uraw(2*(i-1)+2)];
        identity=[1 0; 0 1];
        LHSOp=identity-(Jacob*dt/2);
        newF(i,:)=updateF(i,fx(i),fy(i));
        RHSOp=(-newF/(6*pi)+u);
        RHSVar=dt*(RHSOp)*inv(LHSOp);
        RHS(i,1)=RHSVar(1);
        RHS(i,2)=RHSVar(2);
    end
    
    newdat=[RHS(:,1) RHS(:,2) newF(:,1) newF(:,2)];
end