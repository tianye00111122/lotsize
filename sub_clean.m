function [Headway, Accu_Item, Lot_Size,OptShipNum, Max_Index, LatestLot, EarlLot,Old_I] = ...
    sub_clean(Headway, Accu_Item, Lot_Size, Max_Index, LatestLot, EarlLot,Old_I)
OldShipNum=size(Headway,1);
global I;
Crit=inf;
if(Headway(1)==0)
    Crit=1;
elseif(Headway(OldShipNum)==0)
    Crit=0;
end
Lot_Size=Lot_Size(Lot_Size~=0);
Headway=Headway(Headway~=0);
Accu_Item=Accu_Item(Accu_Item~=0);
OptShipNum=size(Headway,1);
DeleteNum=OldShipNum-OptShipNum;
if(Crit==1)
    LatestLot=LatestLot-DeleteNum;
    EarlLot=EarlLot-DeleteNum;
    Old_I = Old_I-DeleteNum;
    I=I-DeleteNum;
    for i=1:DeleteNum
        Max_Index(1)=[];
    end
elseif(Crit==0)
    for i=1:DeleteNum
        Max_Index(OptShipNum+1)=[];
    end
end


