%Take data from FreeFem++ and find next time step
function newdat=updatePot(fx,fy,dt);
    try
        urawdat=importdata('Data/u.dat');
        jacobrawdat=importdata('Data/Jacobian.dat');
    catch
        urawdat=importdata('Data\u.dat');
        jacobrawdat=importdata('Data\Jacobian.dat');
    end
    jacobrawdat=transpose(jacobrawdat);
    u=transpose(urawdat);
    Jacob=[jacobrawdat(1) jacobrawdat(2); jacobrawdat(3) jacobrawdat(4)];
    identity=[1 0; 0 1];
    LHSOp=identity-(Jacob*dt/2);
    newF=updateF(fx,fy);
    RHSOp=(-newF/(6*pi)+u);
    RHS=dt*(RHSOp)*inv(LHSOp);
    newdat=[RHS(1) RHS(2) newF(1) newF(2)];
end