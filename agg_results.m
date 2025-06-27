function agg_results()
global Ci Cr Ct Tmax;
Tmax=100;
Ci=1;
mCr=1;
mCi=1;
SurfCost=zeros(mCr,mCi);
SurfRatio=zeros(mCr,mCi);
ArrayForJournalC=zeros(mCr,1);
ArrayForJournalSLL=zeros(mCr,1);

%%
% figure(1)
% for iCr=0:2
%     Cr=10^(iCr)
%     %Cr=10;
%     for iCt=0:2
%         Ct=100*5^(iCt)
%        % Ct=400;
%         [finalShipNum,LSofMax,IRRatio,Cost]=main();
%         xx=1:1:finalShipNum;
%         
%         subplot(3,3,3*iCr+iCt+1);
%         %LSofMax=repmat(104,[24 1]);
%         %xx=1:1:24;
%         bar(xx,LSofMax); 
%         title(['Cr=',num2str(Cr),', Ct=',num2str(Ct)],'fontsize',18,'fontweight','bold');
%         xlim([0 finalShipNum(1)+1]);
%         ylim([0 20*floor(max(LSofMax)/20)+20]);
%         xlabel('Shipment','fontsize',18,'fontweight','bold');
%         ylabel('Lot Size','fontsize',18,'fontweight','bold');
%         set(gca,'FontSize',14,'FontWeight','bold');
%     end
% end

%%
%colorstring = 'kbgry';
% Ct=10000;
% for iCi= 1:1:mCi
%     Ci=(iCi)*2
%     for iCr=1:1:mCr
%         Cr=(iCr-1)*500
%         [finalShipNum,LSofMax,RIRatio,Cost,CostT,CostI,CostR,SLLL]=main();
%         %SurfCost(iCr,iCi)=Cost;
%         ArrayForJournalC(iCr)=CostT+CostI;
%         ArrayForJournalSLL(iCr)=SLLL;
%     end
%     %plot(ArrayForJournalC,ArrayForJournalSLL, 'Color', colorstring(int8(iCi)))
%     scatter(ArrayForJournalC(1),ArrayForJournalSLL(1))
%     hold on
%     plot(ArrayForJournalC(2:mCr),ArrayForJournalSLL(2:mCr))
%     hold on
%     ArrayForJournalC=zeros(mCr,1);
%     ArrayForJournalSLL=zeros(mCr,1);
% end
% hold off
% title('Pareto Improving Line','fontsize',18,'fontweight','bold');
% xlabel('Cost ($)','fontsize',18,'fontweight','bold');
% ylabel('Storage Space (items)','fontsize',18,'fontweight','bold');
%legend('Ct=10000, Ci=1','Ct=10000, Ci=2','Ct=10000, Ci=3','Ct=10000, Ci=4')
%%
%Ct=10000;
Ct=50;
for iCr=1:1:mCr
    %Cr=(iCr-1)*5000
    Cr=0
    for iCi= 1:1:mCi
        %Ci=(iCi)*1
        Ci=0.02
        [finalShipNum,LSofMax,RIRatio,Cost,CostT,CostI,CostR,SLLL]=main();
        %SurfCost(iCr,iCi)=Cost;
        SurfRatio(iCi,iCr)=log10(RIRatio);
    end
end

figure (1)
surf(SurfRatio);
f1=get(gca,'xtick');
f2=get(gca,'ytick');
new_ticks1=(f1+1)*2500;
new_ticks2=(f2+1)*0.5;
set(gca,'xticklabel',new_ticks1);
set(gca,'yticklabel',new_ticks2);
title('Log(Rent Cost / Inve Cost) (Ct=10,000)','fontsize',18,'fontweight','bold');
xlabel('C_r','fontsize',18,'fontweight','bold');
ylabel('C_i','fontsize',18,'fontweight','bold');
%zlabel('Log(Rent Cost / Inventory Cost','fontsize',12,'fontweight','bold');
set(gca,'fontweight','bold');
        