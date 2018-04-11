function analyze(filename)
    raw=importdata(filename);
    x=raw(:,1);
    y=raw(:,2);
    plot(x,y);
end