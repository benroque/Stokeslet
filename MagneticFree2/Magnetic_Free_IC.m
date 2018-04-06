function Magnetic_Free_IC(dt,xIC,yIC,FxIC,FyIC)
    %Write IC file
    file = fopen('Magnetic_Free_IC.dat','w');
    fprintf(file,'%.20e \n',dt);
    fprintf(file,'%.20e \n',xIC);
    fprintf(file,'%.20e \n',yIC);
    fprintf(file,'%.20e \n',FxIC);
    fprintf(file,'%.20e \n',FyIC);
    fclose(file);
end