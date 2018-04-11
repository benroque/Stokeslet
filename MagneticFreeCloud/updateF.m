function newF = updateF(i,fx,fy)
   try
       curlrawdat=importdata('Data/curl.dat');
   catch
       curlrawdat=importdata('Data\curl.dat');
   end
   curlrawdat=transpose(curlrawdat);
   fmag=sqrt(fx^2+fy^2);
   dx=fx/fmag;
   dy=fy/fmag;
   dfx=-curlrawdat(i)*dy;
   dfy=curlrawdat(i)*dx;
   newF=[(dx+dfx)*fmag (dy+dfy)*fmag];
end
