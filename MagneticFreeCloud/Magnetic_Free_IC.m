function Magnetic_Free_IC(dt,xIC,yIC,FxIC,FyIC)
    %Write IC file
    file = fopen('Magnetic_Free_IC.dat','w');
    fprintf(file,'%.20e \n',dt);
    numpts=length(xIC);
    fprintf(file,'%d \n',numpts);
    if(length(xIC)~=length(yIC)&&length(yIC)~=length(FxIC)&&length(FxIC)~=length(FyIC))
        fprintf("IC\'s are of inconpatible lengths");
    end
    for i=1:numpts
        fprintf(file,'%.20e \n',xIC(i));
        fprintf(file,'%.20e \n',yIC(i));
        fprintf(file,'%.20e \n',FxIC(i));
        fprintf(file,'%.20e \n',FyIC(i));
    end
    fclose(file);
end