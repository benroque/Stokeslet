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
   newF=[(fx+dfx)*fmag (fy+dfy)*fmag];
end