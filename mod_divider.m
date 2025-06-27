function accuP = mod_divider()

global oStartPoint Tmax;

accuP = 1;

oStartPoint(accuP)=0;

for i=1:1:Tmax-1
    if(sub_Dfunction(i,1)<sub_Dfunction(i-1,1)&&...
            sub_Dfunction(i,1)<sub_Dfunction(i+1,1))
        accuP = accuP+1;
        oStartPoint(accuP)=i;
    end
end

