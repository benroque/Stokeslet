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
