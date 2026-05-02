clc; 
clear;
C = [1 2 3 0 0]; A = [1 2 0 1 0; 3 0 4 0 1]; b = [20; 30];
[m, n] = size(A); Y = [A b]; bv = n-m+1:n;
for s = 1:50
  ZjCj = C(bv)*Y(:,1:n)-C;
  Z = C(bv)*Y(:,end);
  fprintf('\nIteration %d\n', s);
  disp(array2table([ZjCj Z; Y], 'VariableNames',{'x1','x2','x3','s1','s2','Sol'}))
  if all(ZjCj >= 0), break; end
   
  [~, EV] = min(ZjCj);
  ratios = Y(:,end)./Y(:,EV);
  ratios(Y(:,EV)<=0) = inf;
  [~, LV] = min(ratios);
  bv(LV) = EV;
  Y(LV,:) = Y(LV,:)/Y(LV,EV);
  for i = 1:m
      if i~=LV, Y(i,:) = Y(i,:) - Y(i,EV)*Y(LV,:); end
  end
end
