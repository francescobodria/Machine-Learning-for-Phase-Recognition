clear variables
%Lunghezza lato reticolo
N=30;
%Campionatura Temperatura
n=5e4;
%Interazione algoritmo sw
I=1e3;
data=zeros(n,N^2);
magn=zeros(1,n);
LL=round(rand(N))*2-1;
% scelta Temperatura
%T=[linspace(0,2,n/2),linspace(3,5,n/2)];
T=linspace(0,5,n);
parpool()
%tic
%ciclo for parallelo
parfor i=1:length(T)
    [~,griglia]=sw(N,1./T(i),I,LL,0.5);
    data(i,:)=reshape(griglia,1,N^2);
    magn(i)=sum(sum(griglia))/N^2;
end
%toc
delete(gcp)
% ext: dati generati agli estremi
% lim: dati generati su intervallo continuo
% in:  dati generati ripartendo dalla configurazione del reticolo finale del ciclo precedente
% out: dati generati riprendendo configurazione iniziale del reticolo per ogni ciclo 
% out utile perchè si può usare il parallel computing

save('training_sw_30_1e3_lim_out','N','n','I','data','magn','T')
