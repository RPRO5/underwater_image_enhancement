%**********************Jensen.m********************************
function Min= Jensen(Num, w) 

newNum=Num./sum(Num);
newW=w./sum(w);
t=newNum.*log2(newNum);
t1=newW.*log2(newW);
t3=(newNum+newW).*log2((newNum+newW)./2);
dis=(t+t1-t3);
Dis = (1/2)*sum(dis, 2);
Min = Dis;
%Change = 1;
  
%   for i = 2 : OutPL
%       newW=w(i,:)./sum(w(1,:),2);
%       dis=(newNum.*log2(newNum)+newW.*log2(newW)-(newNum+newW).*log2((newNum+newW)/2));
%       Dis = (1/2)*sum(dis, 2);
%        if Dis < Min
%            Min = Dis;
%            Change = i;
%        end
%   end

end
