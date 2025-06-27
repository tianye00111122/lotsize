function sub_up(I)

global Ci Cr Ct OptShipNum up_down_cr;
global EarlLot LatestLot Stick_T;
global Headway Lot_Size Accu_Item;
global Max_Index;
global upreached downreached;
%global Tmax;

Diff = Lot_Size(I+1);
Max_Index(I+1) = 0.5;
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
if(EarlLot>1)
    [x,p1] = sub_findX(Headway(EarlLot-1),Headway(I),Headway(I+1),Cr,Stick_T,Headway(I-1));
elseif(LatestLot>1)
    [x,p1] = sub_findX(0,Headway(I),Headway(I+1),Cr,Stick_T,Headway(LatestLot-1));
else
    [x,p1] = sub_findX(0,Headway(I),Headway(I+1),Cr,Stick_T,0);
end
if( x == inf )
    Stick_T = Stick_T + 1;
    LatestLot = I+1;
    Max_Index(LatestLot) = 1;
    for iii = 1:OptShipNum;
        if(Max_Index(iii) == 1)
            Lot_Size(iii) = Diff;
        end
    end
    
    %elseif( x == Headway(I-1) )
    %    break;
else
    if(up_down_cr == 1)
        downreached = 1;
        Headway(I+1) = x;
        Accu_Item(I+1) = sub_Dfunction(Headway(I+1),0);
        if I<OptShipNum-1
            Lot_Size(I+1) = Accu_Item(I+1)- Accu_Item(I);
        else
            Lot_Size(I+1) = sub_Dfunction(Tmax,0)-Accu_Item(I+1);
        end
        for iii=1:Stick_T;
            Lot_Size(I+iii-1) = p1;
        end
    else
        upreached = 1;
        Headway(LatestLot) = x;
        Accu_Item(LatestLot) = sub_Dfunction(Headway(LatestLot),0);
        if I<OptShipNum-1
            Lot_Size(I+1) = Accu_Item(I+1)- Accu_Item(I);
        else
            Lot_Size(I+1) = sub_Dfunction(Tmax,0)-Accu_Item(I+1);
        end
        for iii=1:OptShipNum
            if(Max_Index(iii)==1)
                Lot_Size(iii) = p1;
            end
        end
    end
end