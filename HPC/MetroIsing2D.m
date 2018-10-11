function [LL,M,corr]=MetroIsing2D(N,bt,T,ll,LL) %con cond periodiche
if nargin < 5
   LL = -1 + 2*round(rand(N,N));
end
if nargin > 3
    corr = zeros(ll,T);
end

M =zeros(T,1);

nnl(1:N)=N^2-N+1:N^2; 
nnl(N+1:N^2)=1:N^2-N;
nnr(N^2-N+1:N^2)=1:N;
nnr(1:N^2-N)=N+1:N^2;
nnu=(1:N^2)-1;
nnu(1:N:(N^2-N+1))=N:N:N^2;
nnd=(1:N^2)+1;
nnd(N:N:N^2)=1:N:(N^2-N+1);

for t=1:T
    I=randperm (N^2);
    for i=I
         deltaE=2*LL(i)*(LL(nnl(i))+LL(nnr(i))+LL(nnu(i))+LL(nnd(i)));
         if deltaE>0
            p_acc=exp(-bt*deltaE);
            a=rand;
            if a < p_acc
               LL(i)= -LL(i);
            end
          else
            LL(i)= -LL(i);
          end
    end
    M(t) = sum(sum(LL)); 
    if nargin > 3  %calcolo correlazione
        LLL = LL;
        for l = 1:ll
            LLL= [LLL(:,2:end) LLL(:,1)];
            corr(l,t) = mean (mean (LL.*LLL));
        end
    end
%     image(100*(LL));
%     pause(0.2)
           
end
end

