function newF = updateF(fx,fy)
   try
       curlrawdat=importdata('Data/curl.dat');
   catch
       curlrawdat=importdata('Data\curl.dat');
   end
   fmag=sqrt(fx^2+fy^2);
   dx=fx/fmag;
   dy=fy/fmag;
   dfx=-curlrawdat*dy;
   dfy=curlrawdat*dx;
   dfmag=sqrt(dfx^2+dfy^2);
   dfx=dfx/dfmag;
   dfy=dfy/dfmag;
   newF=[(dx+dfx)*fmag (dy+dfy)*fmag];
end