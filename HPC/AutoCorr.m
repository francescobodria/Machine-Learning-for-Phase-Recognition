
function res = AutoCorr(cc,ll)

if length(cc) < (ll-1)
    disp('ciccia...')
    return
else
    if length(cc) < 2*ll
        disp('attenzione! pochi dati ...');
    end
end

for i = 1:ll
   res(i) = mean(cc(1:(end+1-i)).*cc(i:end)); 
end

res = res - mean(cc)^2;

res = res/res(1);
