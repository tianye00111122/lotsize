function [bestls,besthw,bestai,besthd]=mod_solver(eTime,sTime,Start_P1,End_P1)

%%
%parameter setup
global Dflag up_down_cr OptShipNum I golint
global Ci Cr Ct
global EarlLot LatestLot Stick_T
global Headway Lot_Size Accu_Item Headway_Diff
global Max_Index
global upreached downreached
global overall_bcost
global bestls besthw bestai besthd

global sx sy ex ey

It_Num = 100;%max interation num
Int=golint;%lot size iteration interval

TTCost=zeros((End_P1-Start_P1)/Int+1,1);
BestShipNum=zeros((End_P1-Start_P1)/Int+1,1);
Pointer=1;

overall_bcost = inf;

for pp1=Start_P1:Int:End_P1
    %%    
    upreached = 0;
    downreached = 0;
    sub_findopt(pp1,eTime);%start with an initial solution
    %%    
    iteration=1;
    [C,I] = max(Lot_Size);%find the max lot size
    if(I == 1)
        downreached = 2;
    elseif(I == OptShipNum)
        upreached = 2;
    end
    Old_I=inf;
    Old_Cost = inf;
    Gap=inf;
    Max_Index = zeros(OptShipNum,1);
    Max_Index(I) = 1;
    LatestLot = I;
    EarlLot = I;
    up_down_cr = 0;
    %%
    %main iteration
    Stick_T = 1;
    for it=1:It_Num 
        %bar(Lot_Size);
        
        
        [Cnew,Max_Index,Stick_T,LatestLot,EarlLot]=sub_findmax(Lot_Size);
        
        stop_cr=sub_udcr(Old_I);
        if(stop_cr == 1)
            break;
        end
        %%
        %when going up
        switch up_down_cr
            case 0
                sub_up(I);%go up
            case 1
                sub_down(I);%go down
        end
        
        iteration=iteration+1;
        if(EarlLot==1 && LatestLot==OptShipNum)
            break;
        end
        %%
        %update the Accu_Item and Headway
        Old_I = I;
        Old_I = sub_inve(I,Old_I,eTime,sTime);%inventorlize lot size and clean
        %update the cost
        [Gap,Cost,I,C,Old_Cost]=sub_updatecost(Old_I,I,Old_Cost);
        if(abs(Gap)<1)
            break;
        end
        
    end
    TTCost(Pointer)=Cost;
    BestShipNum(Pointer)=size(Headway,1);
    Pointer=Pointer+1;
    
end
%%
%outputs
%Old_Cost
%figure(1);
%bar(Lot_Size);
%plot(TTCost);

%plotyy(1:(End_P1-Start_P1)/Int+1,TTCost,1:(End_P1-Start_P1)/Int+1,BestShipNum);

%iteration-1
%Lot_Size
%Headway_Diff
%Accu_Item
%overall_bcost
%bestls
%besthw
%bestai
%besthd

