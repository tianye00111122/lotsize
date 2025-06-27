function sub_down(I)

global Ci  Cr  Ct OptShipNum;
global EarlLot LatestLot Stick_T;
global Headway Lot_Size Accu_Item;
global Max_Index;

Diff = Lot_Size(I-1);
Max_Index(I-1) = 0.5;
for ii=1:OptShipNum;
    if(Max_Index(ii) == 1)
        Diff = Diff+Lot_Size(ii);
    end
end
Diff = Diff/(Stick_T+1);
for ii=1:OptShipNum
    if Max_Index(ii)==1
        LatestLot=ii;
    end
end
if(I>2)
    [x,p1] = sub_findX(Headway(I-2),Headway(I-1),Headway(LatestLot),Cr,Stick_T,Headway(I));
else
    [x,p1] = sub_findX(0,Headway(I-1),Headway(LatestLot),Cr,Stick_T,Headway(I));
end
if( x == inf )
    Stick_T = Stick_T + 1;
    Max_Index(I-1) = 1;
    for iii = 1:OptShipNum;
        if(Max_Index(iii) == 1)
            Lot_Size(iii) = Diff;
        end
    end
    EarlLot = I-1;
%elseif( x == Headway(I-1) )
%    break;
else
    Headway(I-1) = x;
    Accu_Item(I-1) = sub_Dfunction(Headway(I-1),0);
    if I>2
        Lot_Size(I-1) = Accu_Item(I-1)- Accu_Item(I-2);
    else
        Lot_Size(I-1) = Accu_Item(I-1);
    end
    for iii=1:Stick_T;
        Lot_Size(I+iii-1) = p1;
    end
end