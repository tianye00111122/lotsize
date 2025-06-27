function Old_I=sub_inve(I,Old_I,eTime,sTime)

global OptShipNum up_down_cr Tmax;
global EarlLot LatestLot;
global Headway Lot_Size Accu_Item Headway_Diff;
global Max_Index;

Accu_Item(1) =  Lot_Size(1);
Headway(1) = sub_Dfunction(Accu_Item(1),2);
for iii=2:OptShipNum;
    Accu_Item(iii) = Accu_Item(iii-1) + Lot_Size(iii);
    Headway(iii) = sub_Dfunction(Accu_Item(iii),2);
end
switch up_down_cr
    case 1
        if(EarlLot~=1)
            if(Max_Index(EarlLot-1)==0)
                for ii=EarlLot-1:-1:2
                    HeadDiff = Lot_Size(ii+1)/sub_Dfunction(Headway(ii),1);
                    if HeadDiff > Headway(ii)
                        for iii=1:ii-1
                            Lot_Size(iii) = 0;
                            Accu_Item(iii) = 0;
                            Headway(iii) = 0;
                        end
                        Lot_Size(ii) = Accu_Item(ii+1)-Lot_Size(ii+1);
                        break;
                    else
                        Lot_Size(ii) = Accu_Item(ii)-sub_Dfunction(Headway(ii)-HeadDiff,0);
                    end
                    Accu_Item(ii-1) = Accu_Item(ii) - Lot_Size(ii);
                    Headway(ii-1) = sub_Dfunction(Accu_Item(ii-1),2);
                end
            elseif(Max_Index(EarlLot-1)==0.5)
                for ii=EarlLot-2:-1:2
                    HeadDiff = Lot_Size(ii+1)/sub_Dfunction(Headway(ii),1);
                    if HeadDiff > Headway(ii)
                        for iii=1:ii-1
                            Lot_Size(iii) = 0;
                            Accu_Item(iii) = 0;
                            Headway(iii) = 0;
                        end
                        Lot_Size(ii) = Accu_Item(ii+1)-Lot_Size(ii+1);
                        break;
                    else
                        Lot_Size(ii) = Accu_Item(ii)-sub_Dfunction(Headway(ii)-HeadDiff,0);
                    end
                    Accu_Item(ii-1) = Accu_Item(ii) - Lot_Size(ii);
                    Headway(ii-1) = sub_Dfunction(Accu_Item(ii-1),2);
                end
            end
        end
    case 0
        if(Max_Index(LatestLot)==1)
            for ii=LatestLot+1:1:OptShipNum
                if(ii==2)
                    LotDiff = sub_Dfunction(Accu_Item(ii-1),2)*sub_Dfunction(Headway(ii-1),1);
                else
                    LotDiff = (sub_Dfunction(Accu_Item(ii-1),2)-sub_Dfunction(Accu_Item(ii-2),2))*sub_Dfunction(Headway(ii-1),1);
                end
                if (LotDiff+Accu_Item(ii-1) > Accu_Item(OptShipNum))
                    for iii=ii+1:OptShipNum
                        Lot_Size(iii) = 0;
                        Accu_Item(iii) = 0;
                        Headway(iii) = 0;
                    end
                    Lot_Size(ii) = sub_Dfunction(eTime,0)-Accu_Item(ii-1);
                    break;
                else
                    Lot_Size(ii) = LotDiff;
                end
                Accu_Item(ii) = Accu_Item(ii-1) + Lot_Size(ii);
                Headway(ii) = sub_Dfunction(Accu_Item(ii),2);
            end
        elseif(Max_Index(LatestLot)==0.5)
            for ii=LatestLot+2:1:OptShipNum
                
                LotDiff = (sub_Dfunction(Accu_Item(ii-1),2)-sub_Dfunction(Accu_Item(ii-2),2))*sub_Dfunction(Headway(ii-1),1);
                
                if (LotDiff+Accu_Item(ii-1) > Accu_Item(OptShipNum))
                    for iii=ii+1:OptShipNum
                        Lot_Size(iii) = 0;
                        Accu_Item(iii) = 0;
                        Headway(iii) = 0;
                    end
                    Lot_Size(ii) = Accu_Item(OptShipNum)-Accu_Item(ii-1);
                    break;
                else
                    Lot_Size(ii) = LotDiff;
                end
                Accu_Item(ii) = Accu_Item(ii-1) + Lot_Size(ii);
                Headway(ii) = sub_Dfunction(Accu_Item(ii),2);
            end
        end
end
[Headway, Accu_Item, Lot_Size,OptShipNum, Max_Index, LatestLot,...
    EarlLot,Old_I] = sub_clean(Headway, Accu_Item, Lot_Size, Max_Index, LatestLot, EarlLot,Old_I);
Lot_Size(1) = sub_Dfunction(Headway(1),0);
%update the Accu_Item and Headway again
Accu_Item(1) =  Lot_Size(1);
Headway(1) = sub_Dfunction(Accu_Item(1),2);
for iii=2:OptShipNum;
    Accu_Item(iii) = Accu_Item(iii-1) + Lot_Size(iii);
    Headway(iii) = sub_Dfunction(Accu_Item(iii),2);
end
