function sub_findopt(p1,eTime)

global Headway Lot_Size Accu_Item Headway_Diff OptShipNum sx sy;

Reso=1;
a=p1;

Headway = zeros(100,1);
Accu_Item = zeros(100,1);
Lot_Size = zeros(100,1);
Head_Diff = zeros(100,1);
Dmax = sub_Dfunction(eTime-sx,0);

Lot_Size(1) = a;
Accu_Item = a;
shipNum = 1;
Headway(1) = sub_Dfunction(Accu_Item(1),2);
Head_Diff(1) = Headway(1);
while Accu_Item(shipNum) < Dmax
    shipNum=shipNum+1;
    Lot_Size(shipNum) = sub_Dfunction(Headway(shipNum-1),1)*Head_Diff(shipNum-1);
    Accu_Item(shipNum) = Accu_Item(shipNum-1)+Lot_Size(shipNum);
    if Accu_Item(shipNum) > Dmax
        Accu_Item(shipNum) = Dmax;
        Lot_Size(shipNum) = Accu_Item(shipNum) - Accu_Item(shipNum-1);
        if Lot_Size(shipNum) < 0*Lot_Size(shipNum-1)
            shipNum = shipNum-1;
            Lot_Size(shipNum) = Dmax - Accu_Item(shipNum-1);
            Lot_Size(shipNum+1) = 0;
            Accu_Item(shipNum) = Dmax;
            Accu_Item(shipNum+1) = 0;
        end
    end
    Headway(shipNum) = sub_Dfunction(Accu_Item(shipNum),2);
    Head_Diff(shipNum) = Headway(shipNum)-Headway(shipNum-1);
end
    
%%
Lot_Size=Lot_Size(Lot_Size~=0);
Headway=Headway(Headway~=0);
Accu_Item=Accu_Item(Accu_Item~=0);
OptShipNum=size(Headway,1);
Head_Diff=Head_Diff(Head_Diff>0);

