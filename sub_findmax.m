function [Cnew,Inew,NumOfMaxShip,LatestLot,EarlLot]=sub_findmax(Lot_Size)
global OptShipNum
Cnew=Lot_Size(1);
Inew=zeros(OptShipNum,1);
Inew(1)=1;
NumOfMaxShip=1;
for i=2:OptShipNum
    if(Lot_Size(i)>Cnew)
        Cnew=Lot_Size(i);
        Inew(:)=0;
        Inew(i)=1;
        NumOfMaxShip=1;
    elseif(Lot_Size(i)==Cnew)
        Inew(i)=1;
        NumOfMaxShip=NumOfMaxShip+1;        
    end        
end
for i=1:OptShipNum
    if(Inew(i)==1)
        EarlLot=i;
        break;
    end
end
for i=OptShipNum:-1:1
    if(Inew(i)==1)
        LatestLot=i;
        break;
    end
end