function [finalShipNum,LS,RIRatio,Cost,CostT,CostI,CostR,SLLL]=main()

global Ci Cr Ct golint
global findXint Tmax Dflag
global oStartPoint
global sx sy ex ey
%Ci = 1;%inventory cost
%Ct = 40;%transportation cost
%Tmax = 100;%maximum of time
findXint = 0.05;
Dflag = 4;
golint=2;
SP1=2;
EP1=300;
maxmaxLS = 0;

% sx = 0;
% sy = 0;
% pNum = mod_divider();
sx=0;%start point of x
sy=0;%start point of y
ex=0;%end point of x
ey=0;%end point of y

% for i=1:1:pNum
%     sx = oStartPoint(i);
%     sy = sub_Dfunction(0,0);    
    
    Start_P1=SP1;%smallest lot size of p1
    End_P1=EP1;%largest lot size of p1
    [LS,HW,AI,HD] = mod_solver(Tmax,0,Start_P1,End_P1);
%     if(i==pNum)
%         ey = sub_Dfunction(Tmax-sx,0)+sy;
%         ex = Tmax;
%         [LS,HW,AI,HD] = mod_solver(Tmax,oStartPoint(i),Start_P1,End_P1);
%     elseif(i<pNum)
%         ex = oStartPoint(i+1); 
%         ey = sub_Dfunction(oStartPoint(i+1),0);
%         [LS,HW,AI,HD] = mod_solver(oStartPoint(i+1),oStartPoint(i),Start_P1,End_P1);
%     end
%     if(max(LS)>maxmaxLS)
%     %if(i==1)%just for test
%         maxmaxLS = max(LS);
%         LSofMax = LS;
%         HWofMax = HW;
%         AIofMax = AI;
%         HDofMax = HD;
%         maxP = i;
%     end
% end
finalShipNum = size(LS,1);
% sx = 0;
% sy = 0;
% if(pNum>1)
%     [LSofMax,HWofMax,AIofMax,HDofMax,finalShipNum]=mod_sticker(maxP,LSofMax,HWofMax,AIofMax,HDofMax);
% end
%xx = 1:1:finalShipNum;
%bar(xx,LSofMax);
Holding=0;
for iii=1:finalShipNum
    Holding=Holding+Ci*AI(iii)*HD(iii);
end
[C1,I1] = max(LS);
switch Dflag
    case 1
        Holding=Holding-83500*Ci;
    case 2
        Holding=Holding-166500*Ci;
    case 3
        Holding=Holding-125000*Ci;
    case 4
        Holding=Holding-113313*Ci;
end
Cost = C1*Cr+Holding;
Cost = Cost+Ct*finalShipNum;
RIRatio=(C1*Cr)/Holding;
CostT = Ct*finalShipNum;
CostI = Holding;
CostR = C1*Cr;
SLLL = C1;
LS
HW
CostT
CostI
CostR

