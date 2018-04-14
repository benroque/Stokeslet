function analyze(filename)
    raw=importdata(filename);
    x=raw(:,1);
    y=raw(:,2);
    x1=x(1:2:end);
    x2=x(2:2:end);
    y1=y(1:2:end);
    y2=y(2:2:end);
    plot(x1,y1,x2,y2)
%     xdif=x1-x2;
%     ydif=y1-y2;
%     plot(xdif,ydif)
end