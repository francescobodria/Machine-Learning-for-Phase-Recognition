% bt=1./linspace(1,5,150);
bt=0.43;
%Numero di Interazioni degli algoritmi
I=300000;
%campionatura Temperatura
n=length(bt);
%data_metro=zeros(n,900,I);
magn_metro=zeros(n,I);
%data_sw=zeros(n,900,I);
magn_sw=zeros(n,I);
exp_sw=zeros(2,I,n);
exp_metro=zeros(2,I,n);
%caricamento rete neurale
load rete
%parpool()
tic
%ciclo inutile se beta è un numero, ma ho dovuto dividere i beta in più file in modo tale da usare più processori alla volta
% inoltre data_metro e data_sw non ho potetuto salvarle causa problemi di grandezza
for i=1:n
    
    %creazione reticolo iniziale 30x30 usando sw con 1000 iterazioni
    [Magn,LL]=sw(30,bt(i),1000);
    
    %calcolo risultato iniziale ottenuto dalla rete
    exp_metro(:,1,i)=sim(net_100_2_lim_in.net,reshape(LL,1,900)');
    
    %salvataggio dati di partenza
    %data_metro(i,:,1)=reshape(LL,1,900);
    magn_metro(i,1)=Magn(end);

    for j=2:I
        
	[LL,Magn]=MetroIsing2D(30,bt(i),1,0,LL);
	
	%calcolo responso della rete sul reticolo
        exp_metro(:,j,i)=sim(net_100_2_lim_in.net,reshape(LL,1,900)');
        
	%salvataggio variabili
	%data_metro(i,:,j)=reshape(LL,1,900);%
        magn_metro(i,j)=Magn;
    end
    
    %ora tocca a sw
    [Magn,LL]=sw(30,bt(i),1000);
    %data_sw(i,:,1)=reshape(LL,1,900);
    magn_sw(i,1)=Magn(end);
    exp_sw(:,1,i)=sim(net_100_2_lim_in.net,reshape(LL,1,900)');
    
    for j=2:I
        [Magn,LL]=sw(30,bt(i),1,LL);
        %data_sw(i,:,j)=reshape(LL,1,900);
        exp_sw(:,j,i)=sim(net_100_2_lim_in.net,reshape(LL,1,900)');
        magn_sw(i,j)=Magn; 
    end
end
toc
%delete(gcp)

%Lunghezza di autocorrelazione
L=300;
cc_metro=zeros(L,3);
cc_sw=zeros(L,3);

%calcolo autocorrelazioni
cc_metro(:,1)=AutoCorr(magn_metro(i,:),L);
cc_sw(:,1)=AutoCorr(magn_sw(i,:),L);
cc_metro(:,2)=AutoCorr(squeeze(exp_metro(1,:,i)),L);
cc_sw(:,2)=AutoCorr(squeeze(exp_sw(1,:,i)),L);
cc_metro(:,3)=AutoCorr(squeeze(exp_metro(2,:,i)),L);
cc_sw(:,3)=AutoCorr(squeeze(exp_sw(2,:,i)),L);

save('data_043')


%figure(1)
%plot(cc_metro(:,1))
%hold on
%plot(cc_metro(:,2))
%plot(cc_metro(:,3))
%figure(2)
%plot(cc_sw(:,1))
%hold on
%plot(cc_sw(:,2))
%plot(cc_sw(:,3))


