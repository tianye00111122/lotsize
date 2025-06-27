function enum4()
global Dflag
Dflag=4;
Cr=10;
Ct=400;
n=4;
distance=1;
Bcost=inf;
lot=zeros(n,1);
t=zeros(n,1);
td=zeros(n,1);
optH=zeros(n,1);
optL=zeros(n,1);
inve=zeros(n,1);
inveT=0;
switch Dflag
    case 1
        for t1=1:distance:(100-n*distance)
            for t2=1:distance:97-(n-1)*distance
                if(t1+t2<100-(n-2)*distance)
                    for t3=1:distance:97
                        if(t1+t2+t3<100-distance)
                            t4=100-t1-t2-t3;
                            t(1)=t1;
                            t(2)=t2+t(1);
                            t(3)=t3+t(2);
                            t(4)=100;
                            td(1)=t1;
                            td(2)=t2;
                            td(3)=t3;
                            td(4)=t4;
                            
                            lot(1)=(t(1)^2)/4;
                            inveT=td(1)*lot(1);
                            
                            for i = 2:4
                                lot(i)=(t(i)^2-t(i-1)^2)/4;
                                inveT=inveT+td(i)*(t(i)^2)/4;
                            end
                            
                            cost=Cr*max(lot)+inveT+Ct*4;
                            if cost<Bcost
                                for iii=1:4
                                    optH(iii)=td(iii);
                                    optL(iii)=lot(iii);
                                end
                                Bcost=cost;
                            end
                        end
                    end
                end
            end
        end
        
    case 2
        for t1=1:distance:97
            for t2=1:distance:97
                if(t1+t2<100-2*distance)
                    for t3=1:distance:97
                        if(t1+t2+t3<100-distance)
                            t4=100-t1-t2-t3;
                            t(1)=t1;
                            t(2)=t2+t(1);
                            t(3)=t3+t(2);
                            t(4)=100;
                            td(1)=t1;
                            td(2)=t2;
                            td(3)=t3;
                            td(4)=t4;
                            
                            lot(1)=250*sqrt(t(1));
                            inveT=td(1)*lot(1);
                            
                            for i = 2:4
                                lot(i)=250*sqrt(t(i))-250*sqrt(t(i-1));
                                inveT=inveT+td(i)*250*sqrt(t(i));
                            end
                            
                            cost=Cr*max(lot)+inveT+Ct*4;
                            if cost<Bcost
                                for iii=1:4
                                    optH(iii)=td(iii);
                                    optL(iii)=lot(iii);
                                end
                                Bcost=cost;
                            end
                        end
                    end
                end
            end
        end
    case 3
        for t1=1:distance:97
            for t2=1:distance:97
                if(t1+t2<100-2*distance)
                    for t3=1:distance:97
                        if(t1+t2+t3<100-distance)
                            t4=100-t1-t2-t3;
                            t(1)=t1;
                            t(2)=t2+t(1);
                            t(3)=t3+t(2);
                            t(4)=100;
                            td(1)=t1;
                            td(2)=t2;
                            td(3)=t3;
                            td(4)=t4;
                            
                            lot(1)=2685*(1/(1+exp((-t(1)+50)/15))-1/(1+exp(50/15)));
                            inveT=td(1)*lot(1);
                            
                            for i = 2:4
                                lot(i)=2685*(1/(1+exp((-t(i)+50)/15)))-2685*(1/(1+exp((-t(i-1)+50)/15)));
                                inveT=inveT+td(i)*(2685*(1/(1+exp((-t(i)+50)/15))-1/(1+exp(50/15))));
                            end
                            
                            cost=Cr*max(lot)+inveT+Ct*4;
                            if cost<Bcost
                                for iii=1:4
                                    optH(iii)=td(iii);
                                    optL(iii)=lot(iii);
                                end
                                Bcost=cost;
                            end
                        end
                    end
                end
            end
        end
    case 4
        for t1=1:distance:97
            for t2=1:distance:97
                if(t1+t2<100-2*distance)
                    for t3=1:distance:97
                        if(t1+t2+t3<100-distance)
                            t4=100-t1-t2-t3;
                            t(1)=t1;
                            t(2)=t2+t(1);
                            t(3)=t3+t(2);
                            t(4)=100;
                            td(1)=t1;
                            td(2)=t2;
                            td(3)=t3;
                            td(4)=t4;
                            %
                            if t(1)<25
                                lot(1)=(t(1)^2)*2500/3566;
                            elseif t(1)<64
                                lot(1)=(500*sqrt(t(1))-1875)*2500/3566;
                            else
                                lot(1)=((t(1)^2)*1000/4096+1125)*2500/3566;
                            end
                            
                            inveT=td(1)*lot(1);
                            %also need to detect the location of t(i-1)
                            for i = 2:4
                                if t(i)<25
                                    lot(i)=(t(i)^2)*2500/3566-(t(i-1)^2)*2500/3566;
                                    inveT=inveT+td(i)*(t(i)^2)*2500/3566;
                                elseif t(i)<64
                                    if t(i-1)<25
                                        lot(i)=(500*sqrt(t(i))-1875)*2500/3566-(t(i-1)^2)*2500/3566;
                                    elseif t(i-1) <64
                                        lot(i)=(500*sqrt(t(i))-1875)*2500/3566-(500*sqrt(t(i-1))-1875)*2500/3566;
                                    end
                                    inveT=inveT+td(i)*(500*sqrt(t(i))-1875)*2500/3566;
                                else
                                    if t(i-1)<25
                                         lot(i)=((t(i)^2)*1000/4096+1125)*2500/3566-(t(i-1)^2)*2500/3566;
                                    elseif t(i-1)<64
                                         lot(i)=((t(i)^2)*1000/4096+1125)*2500/3566-(500*sqrt(t(i-1))-1875)*2500/3566;
                                    else
                                         lot(i)=((t(i)^2)*1000/4096+1125)*2500/3566-((t(i-1)^2)*1000/4096+1125)*2500/3566;
                                    end
                                    inveT=inveT+td(i)*((t(i)^2)*1000/4096+1125)*2500/3566;
                                end
                            end
                         
                            cost=Cr*max(lot)+inveT+Ct*4;
                            if cost<Bcost
                                for iii=1:4
                                    optH(iii)=td(iii);
                                    optL(iii)=lot(iii);
                                end
                                Bcost=cost;
                            end
                        end
                    end
                end
            end
        end
end
Bcost
optH
figure(1)
bar(optL)
optL

