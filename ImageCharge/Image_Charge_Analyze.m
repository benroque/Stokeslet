y=posDat(:,2);
t=linspace(0,tFinal,length(y));
Data=[y transpose(t)];

Data(Data(:,1)<0)=[];

tnew=max(Data(:,2))-Data(:,2);

Data=[Data(:,1) tnew];

plot(log(Data(:,2)),log(Data(:,1)))