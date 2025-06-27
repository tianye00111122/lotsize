function [Headway, Lot_Size, Accu_Item, Head_Diff, OptShipNum] = sub_findopt_random(n,horizon)
Headway = zeros(n,1);
Lot_Size = zeros(n,1);
Accu_Item = zeros(n,1);
OptShipNum = n;
for i=1:n-1
    Headway(i) = round((1+horizon)*(ceil(random('uniform',1,horizon))+i)/100);
end
%Headway=[44 65 72 100];
Headway(n) = horizon;
Headway = sort(Headway);
Accu_Item(1) = sub_Dfunction(Headway(1),0);
Lot_Size(1) = Accu_Item(1);
Head_Diff(1)= Headway(1);
for i=2:n
    Accu_Item(i) = sub_Dfunction(Headway(i),0);
    Lot_Size(i) = Accu_Item(i)-Accu_Item(i-1);
    Head_Diff(i) = Headway(i)- Headway(i-1);
end
