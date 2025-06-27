function [xx,p1]=sub_findX(xm1,x,xp1,Cr,Stick_T,xn)
global up_down_cr findXint Ci;
switch up_down_cr
    case 1
        xx = inf;
        for ii=x:findXint:xn;
            a=Ci*(sub_Dfunction(ii,1)*(ii-xm1-Cr/Stick_T));
            b=(sub_Dfunction(ii,0)-sub_Dfunction(xm1,0));
            if(Ci*(sub_Dfunction(ii,1)*(ii-xm1-Cr/Stick_T))<(sub_Dfunction(ii,0)-sub_Dfunction(xm1,0)))
                %if(Ci*(sub_Dfunction(ii,1)*(ii-xm1-Cr/Stick_T))>(sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/Stick_T)
                break;
            end
            %Crit = Stick_T*Ci*sub_Dfunction(ii,1)*(ii-xm1-Cr/Stick_T)+sub_Dfunction(ii,0)-sub_Dfunction(xp1,0);
            %Crit = Stick_T*Ci*(sub_Dfunction(ii,1)*(ii-xm1)-(sub_Dfunction(xp1,0))-sub_Dfunction(ii,0))-Cr*sub_Dfunction(ii,1);
            Crit = Ci*(ii-xm1-(sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/(Stick_T*sub_Dfunction(ii,1)))-Cr/Stick_T;
            if(Crit>=0)
                xx=ii;
                break;
            end
        end
        p1 = (sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/Stick_T;
    case 0
        xx = inf;
        for ii=x:-1*findXint:xn;
            a=Ci*((sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/sub_Dfunction(ii,1)-(ii-xm1)/Stick_T);
            b=Cr/Stick_T;
            if(a>b)
                %if(Ci*(sub_Dfunction(ii,1)*(ii-xm1-Cr/Stick_T))>(sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/Stick_T)
                break;
            end
            Crit = Ci*((sub_Dfunction(xp1,0)-sub_Dfunction(ii,0))/sub_Dfunction(ii,1)-(ii-xm1)/Stick_T)-Cr/Stick_T;
            if(Crit>=0)
                xx=ii;
                break;
            end
        end
        p1 = (sub_Dfunction(ii,0)-sub_Dfunction(xm1,0))/Stick_T;
end


