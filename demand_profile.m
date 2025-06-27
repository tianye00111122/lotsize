function demand_profile()
b=0:1:100;
%a1=(b.^2)/4;
%a2=250*sqrt(b);
%a3=2500*(1/(1+exp((-b+50)/15))-1/(1+exp(50/15)));
figure(1)

plot(b,(b.^2)/4,':r','linewidth',2);

hold all
plot(b,250*b.^0.5,'-.g','linewidth',2)

hold all
plot(b,2685*((1+exp((-b+50)/15)).^-1-(1+exp(50/15)).^-1),'--k','linewidth',2);

hold all
b1=0:.01:25;
b2=25:.01:64;
b3=64:.01:100;
%plot(b1,b1.^2*2500/3566,'b',b2,(500*b2.^0.5-1875)*2500/3566,'b',b3,((b3.^2)*1000/4096+1125)*2500/3566,'b','linewidth',2);
hleg1=legend('(i)','(ii)','(iii)');
set(hleg1,'Location','NorthWest')
set(hleg1,'Interpreter','none')
title('Demand','fontsize',12);
xlabel('time','fontsize',12);
xlim([0,100]);
ylim([0,2500]);


figure(2)
plot(b,(b)/2,':r','linewidth',2);

hold all
plot(b,125*b.^-0.5,'-.g','linewidth',2)

hold all
plot(b,2685*((1+exp((50-b)/15)).^-2).*(exp((50-b)/15)/15).^1,'--k','linewidth',2);

hold all
b1=0:.01:25;
b2=25:.01:64;
b3=64:.01:100;
%plot(b1,b1*2*2500/3566,'b',b2,(250*b2.^-0.5)*2500/3566,'b',b3,((b3*2)*1000/4096)*2500/3566,'b','linewidth',2);
hleg1=legend('(i)','(ii)','(iii)');
hleg2=legend();
set(hleg2,'Location','NorthWest')
set(hleg2,'Interpreter','none')

title('Change rate of Demand','fontsize',12);
xlabel('time','fontsize',12);

xlim([0,100]);
ylim([0,60]);


end