function [res, ret, corr]=sw(N,beta,c,rt,flag)

if nargin==3
    ret = round(rand(N))*2-1;
elseif nargin==4
    ret=rt;
else
    display('Error: incorrect number of input parameters!');
end
p=1-exp(-beta*2);

%storia della magnetizzazione
res=zeros(c,1);
%correlazione spaziale
corr = zeros(c,N);

%matrici dei primi vicini
nnl(1:N)=N^2-N+1:N^2;
nnl(N+1:N^2)=1:N^2-N;
nnr(N^2-N+1:N^2)=1:N;
nnr(1:N^2-N)=N+1:N^2;
nnu=(1:N^2)-1;
nnu(1:N:(N^2-N+1))=N:N:N^2;
nnd=(1:N^2)+1;
nnd(N:N:N^2)=1:N:(N^2-N+1);

%prima colonna= sito up, seconda colonna=sito right
link=zeros(2,N^2);

for k=1:c
%     subplot(1,2,2);    
%     imagesc(ret);
%     axis square;
%     pause(flag);
    
    %matrice dei label dei cluster
    aux=zeros(N);
    
    %riempio link
    for i=1:N^2
        if ret(i)==ret(nnu(i))
            link(1,i)=(rand<p);
        end
        
        if ret(i)==ret(nnr(i))
            link(2,i)=(rand<p);
        end
    end
    
    %riempio aux    
    label=1;
    for i=1:N^2
        
        if aux(i)==0  %allora non l'ho ancora visitato  %comincio la crescita i un cluster a partire da una posizione
            
            aux(i)=label;
            punt_pila=1;
            pila = i;
            
            while punt_pila<=length(pila)
                
                %labello il sito
                
                ii = pila(punt_pila);
                
                %visito il primo vicino up e right
                if link(1,ii)==1 && aux(nnu(ii))==0
                    pila=[pila, nnu(ii)];
                    aux(nnu(ii))=label;
                end
                
                if link(2,ii)==1 && aux(nnr(ii))==0
                    pila=[pila, nnr(ii)];
                    aux(nnr(ii))=label;
                end
                
                if link(1,nnd(ii))==1 && aux(nnd(ii))==0
                    pila=[pila, nnd(ii)];
                    aux(nnd(ii))=label;
                    
                end
             
                if link(2,nnl(ii))==1 && aux(nnl(ii))==0
                    pila=[pila, nnl(ii)];
                    aux(nnl(ii))=label;
                    
                end
                
                punt_pila = punt_pila+1;
                
            end
            
            label = label+1;
            
            valore = 2*round(rand)-1;%round(2*rand-1);
            ret(pila) = valore;
            
        end  %chiude la crescita del cluster che iniziava in i
                
    end  %chiude il ciclo di aggiornamento sul reticolo
    
    %storia della magnetizzazione
    res(k)=sum(sum(ret));

%     aux1 = zeros(N);
%     nclu = max(max(aux));
%     for ij = 1:nclu,
%         ijk = find(aux==ij);
%         aux1(ijk) = 1000*rand;
%     end
%      subplot(1,2,1);    
%      imagesc(10*aux1);
%      axis square;
%      pause(0.5);

    %correlazioni spaziali
%    corr(k,:) = correlation(ret,N);

end  %chiude la singola iterazione

%figure;

end