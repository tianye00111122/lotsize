function [a] = sub_Dfunction(b,flag1)
global Dflag
global sx sy
switch Dflag
    case 1
        switch flag1
            case 0
                a=((b+sx)^2)/4-sy;
            case 1
                a=(b+sx)/2;
            case 2
                a=2*sqrt(b+sy)-sx;
        end
    case 2
        switch flag1
            case 0
                a=250*sqrt(b+sx)-sy;
            case 1
                a=125*(b+sx)^(-0.5);
            case 2
                a=((b+sy)/250)^2-sx;
        end
    case 3
        switch flag1
            case 0
                a=2685*(1/(1+exp((-(b+sx)+50)/15))-1/(1+exp(50/15)))-sy;
            case 1
                a=2685*(1/(1+exp((50-(b+sx))/15)))^2*exp((50-(b+sx))/15)/15;
            case 2
                a=50-15*log(1/((b+sy)/2685+1/(1+exp(50/15)))-1)-sx;
        end
    case 4
        switch flag1
            case 0
                if (b+sx>=0 && b+sx<25)
                    a = ((b+sx)^2)*2500/3566-sy;
                elseif (b+sx>=25 && b+sx<64)
                    a = (500*sqrt(b+sx)-1875)*2500/3566-sy;
                elseif (b+sx>=64)
                    a = (((b+sx)^2)*1000/4096+1125)*2500/3566-sy;
                end
            case 1
                if (b+sx>=0 && b+sx<25)
                    a = 2*(b+sx)*2500/3566;
                elseif (b+sx>=25 && b+sx<64)
                    a = (250/sqrt(b+sx))*2500/3566;
                elseif (b+sx>=64)
                    a = ((b+sx)*2000/4096)*2500/3566;
                end
            case 2
                if (b+sy>=0 && b+sy<438.166)
                    a = sqrt((b+sy)*3566/2500)-sx;
                elseif (b+sy>=438.166 && b+sy<1489.764)
                    a = (((b+sy)*3566/2500+1875)/500)^2-sx;
                elseif (b+sy>=1489.764)
                    a = sqrt(((b+sy)*3566/2500-1125)*4096/1000)-sx;
                end
        end
end