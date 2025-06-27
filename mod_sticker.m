function [finalLS,finalHW,finalAI,finalHD,finalShipNum]=mod_sticker(maxP,LSofMax,HWofMax,AIofMax,HDofMax)

global oStartPoint Tmax
Dmax = sub_Dfunction(Tmax,0);

OptShipNum_M = size(LSofMax,1);
for iiii=1:OptShipNum_M
    HWofMax(iiii)=HWofMax(iiii)+oStartPoint(maxP);
    AIofMax(iiii)=AIofMax(iiii)+sub_Dfunction(oStartPoint(maxP),0);
end
    
finalLS_B(1) = LSofMax(size(LSofMax,1)-1);
finalHW_B(1) = HWofMax(size(HWofMax,1)-1);
finalAI_B(1) = AIofMax(size(AIofMax,2)-1);
finalHD_B(1) = HDofMax(size(HDofMax,2)-1);
shipNum = 1;

while finalAI_B(shipNum) < Dmax
    shipNum=shipNum+1;
    finalLS_B(shipNum) = sub_Dfunction(finalHW_B(shipNum-1),1)*finalHD_B(shipNum-1);
    finalAI_B(shipNum) = finalAI_B(shipNum-1)+finalLS_B(shipNum);
    if finalAI_B(shipNum) > Dmax
        finalAI_B(shipNum) = Dmax;
        finalLS_B(shipNum) = finalAI_B(shipNum) - finalAI_B(shipNum-1);
        if finalLS_B(shipNum) < 0.1*finalLS_B(shipNum-1)
            shipNum = shipNum-1;
            finalLS_B(shipNum) = Dmax - finalAI_B(shipNum-1);
            finalLS_B(shipNum+1) = 0;
            finalAI_B(shipNum) = Dmax;
            finalAI_B(shipNum+1) = 0;
        end
    end
    finalHW_B(shipNum) = sub_Dfunction(finalAI_B(shipNum),2);
    finalHD_B(shipNum) = finalHW_B(shipNum)-finalHW_B(shipNum-1);
end

finalLS_B=finalLS_B(finalLS_B~=0);
finalAI_B=finalAI_B(finalAI_B~=0);
finalHW_B=finalHW_B(finalHW_B~=0);
finalHD_B=finalHD_B(finalHD_B>0);
OptShipNum_B=size(finalHW_B,2);


finalLS_A(1) = LSofMax(2);
finalHW_A(1) = HWofMax(2);
finalAI_A(1) = AIofMax(2);
finalAI_A(2) = AIofMax(1);
finalHD_A(1) = HDofMax(2);
finalHW_A(2) = HWofMax(1);
shipNum = 1;

if(maxP~=1)
    while finalHW_A(shipNum+1) > 0.01
        shipNum=shipNum+1;
        finalHD_A(shipNum) = finalLS_A(shipNum-1)/sub_Dfunction(finalHW_A(shipNum),1);
        finalHW_A(shipNum+1) = finalHW_A(shipNum)-finalHD_A(shipNum);
        if finalHW_A(shipNum+1) < 0
            finalHW_A(shipNum+1) = 0;
            finalHD_A(shipNum) = finalHW_A(shipNum);
        end
        finalAI_A(shipNum+1) = sub_Dfunction(finalHW_A(shipNum+1),0);
        finalLS_A(shipNum) = finalAI_A(shipNum)-finalAI_A(shipNum+1);
    end
    finalLS_A(shipNum) = finalAI_A(shipNum);
else
    finalLS_A(2) = LSofMax(1);
    finalHW_A(2) = HWofMax(1);
    finalAI_A(2) = AIofMax(1);
    finalHD_A(2) =HDofMax(1);    
end


finalLS_A=finalLS_A(finalLS_A~=0);
finalAI_A=finalAI_A(finalAI_A~=0);
finalHW_A=finalHW_A(finalHW_A>=0.01);
finalHD_A=finalHD_A(finalHD_A>0);
OptShipNum_A=size(finalHW_A,2);

finalShipNum = OptShipNum_A+OptShipNum_B+OptShipNum_M-4;
for i=1:OptShipNum_A-1
    finalLS(i) = finalLS_A(OptShipNum_A-i+1);
    finalHW(i) = finalHW_A(OptShipNum_A-i+1);
    finalAI(i) = finalAI_A(OptShipNum_A-i+1);
    finalHD(i) = finalHD_A(OptShipNum_A-i+1);
end
for i=2:OptShipNum_M-1
    finalLS(i+OptShipNum_A-2) = LSofMax(i);
    finalAI(i+OptShipNum_A-2) = AIofMax(i);
    finalHW(i+OptShipNum_A-2) = HWofMax(i);
    finalHD(i+OptShipNum_A-2) = HDofMax(i);
end
for i=2:OptShipNum_B
    finalLS(i+OptShipNum_A+OptShipNum_M-4) = finalLS_B(i);
    finalAI(i+OptShipNum_A+OptShipNum_M-4) = finalAI_B(i);
    finalHW(i+OptShipNum_A+OptShipNum_M-4) = finalHW_B(i);
    finalHD(i+OptShipNum_A+OptShipNum_M-4) = finalHD_B(i);
end



