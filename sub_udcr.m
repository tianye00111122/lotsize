function [stop_cr]=sub_udcr(Old_I)
global EarlLot LatestLot up_down_cr OptShipNum;
global upreached downreached;
global Lot_Size;
global I;
up_down_cr = 1; %0 stands for up and 1 stands for down
stop_cr=0;
% if(I ~= 1 && I ~= OptShipNum)
%     if(Old_I == I)
%         up_down_cr = 1 - up_down_cr;
%     else if(Lot_Size(I-1)<Lot_Size(I+1))
%             up_down_cr = 1;
%         else if(Lot_Size(I-1)>=Lot_Size(I+1))
%                 up_down_cr = 0;
%             end
%         end
%     end
% end

% if(I == 1)
%     up_down_cr = 0;
% elseif(I == OptShipNum)
%     up_down_cr = 1;
% end

if(upreached * downreached > 1)
    stop_cr = 1;
    return;
elseif(upreached * downreached == 1)
    up_down_cr = 1 - up_down_cr;
elseif(upreached == 0 && downreached == 0 && EarlLot ~= 1 && LatestLot ~= OptShipNum)
    if(Lot_Size(EarlLot-1)>Lot_Size(LatestLot+1))
        up_down_cr = 1;
    else
        up_down_cr = 0;
    end
elseif(upreached == 0 || EarlLot == 1)
    up_down_cr = 0;
elseif(downreached == 0 || LatestLot == OptShipNum)
end

if(up_down_cr == 0)
    I = LatestLot;
else
    I = EarlLot;
end

if((EarlLot == 1 && up_down_cr == 1)||(LatestLot==OptShipNum && up_down_cr == 0))
    stop_cr = 1;
end
