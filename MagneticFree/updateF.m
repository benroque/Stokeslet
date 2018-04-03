function newF = updateF(fx,fy)
   curlrawdat=importdata('curl.dat');
   fmag=sqrt(fx^2+fy^2);
   dx=fx/fmag;
   dy=fy/fmag;
   dfx=-curlrawdat*dy;
   dfy=curlrawdat*dx;
   newF=[fx+dfx fy+dfy];
end