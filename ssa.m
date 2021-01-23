function [comp,dd]=ssa(x,L,zz)

% stage 1: creation of trajectory matrix

   NN=length(x); 
   if L>NN/2
       L=NN-L; 
   end
   K=NN-L+1; 
   X=zeros(L,K);                 
   for i=1:K
	X(1:L,i)=x(i:L+i-1); 
   end
    
% stage 2: use of SVD for the decomposition of the covaraince matrix

   S=X*X'; 
   [eigenvectors,eigenvalues]=svds(S);   
   [dd,i]=sort(-diag(eigenvalues));  
   dd=-dd; 
   eigenvectors=eigenvectors(:,i); 
   V=(X')*eigenvectors;
 

% stage 3: Grouping of the components

   Vnew=V';
   grouped_comp=eigenvectors(:,zz)*Vnew(zz,:);

% stage 4: Reconstruction of components

   z=zeros(NN,1);
   L_min=min(L,K);
   K_min=max(L,K);

   for k=1:L_min-1
     for m=1:k
      z(k)=z(k)+grouped_comp(m,k-m+1)/k;
     end
   end

   for k=L_min:K_min
     for m=1:L_min
      z(k)=z(k)+grouped_comp(m,k-m+1)/L_min;
     end
   end

   for k=K_min+1:NN
     for m=k+1-K_min:NN+1-K_min
      z(k)=z(k)+grouped_comp(m,k+1-m)/(NN-k+1);
     end
   end
   comp=z;
end
