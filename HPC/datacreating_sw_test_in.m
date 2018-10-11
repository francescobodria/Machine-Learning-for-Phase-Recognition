clear variables
%Lato del reticolo
N=30;
%campionatura Temperatura
n=150;
%numero di medie da effettuare
m=1000;
%numero di interazioni nell'algoritmo sw
I=1e3;
data=zeros(n,N^2,m);
magn=zeros(n,m);
%tic
for j=1:m
	%crea il reticolo random
	LL=round(rand(N))*2-1;
	
	%% scelta se generare dati di test su tutto l'intervallo o solo su una parte agli estremi 

	%T=[linspace(0,2,n/2),linspace(3,5,n/2)];
	T=linspace(1,5,n);
	
	for i=1:length(T)
		%ciclo per generare dati e magnetizzazione
    		[~,LL]=sw(N,1./T(i),I,LL,0.5);
		data(i,:,j)=reshape(LL,1,N^2);
		magn(i,j)=sum(sum(LL))/N^2;
	end
end
%toc
% ext: dati generati agli estremi
% lim: dati generati su intervallo continuo
% in:  dati generati ripartendo dalla configurazione del reticolo finale del ciclo precedente
% out: dati generati riprendendo configurazione iniziale del reticolo per ogni ciclo 
% out utile perchè si può usare il parallel computing

save('testing_sw_30_1e3_lim_in','N','n','I','m','data','magn','T')
