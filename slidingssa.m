function modes = slidingssa(x, r, W, L, delta,eps)
%======================================================
% Inputs :
% 
% x : input signal
% r : number of components needed
% W : window length
% L : length of embedded vector
% delta : no. of samples between two frames
% 
% Returns:
% 
% modes : components of the signal
%======================================================

if ~exist('delta', 'var')
 delta = 1; 
end

if ~exist('eps', 'var')
    eps = 0.03;
end

N = length(x);
x_hat = zeros(N,r);
% x_tilde = zeros(N,r);

for p = 1: delta : N-W+1
    
    nc = 1 + (W -1)/2;
    m = p + W -1;
    
    x_tilde = ssa_decomp( x(p:m), L, r,eps);
    
    if p == 1
        x_hat(1:nc,:) = x_tilde(1:nc,:);
        
        
    else
        J = [];
    
        
        for j = 1:r
            
            x_tilde_j = x_tilde(1:nc  ,j);
            x_hat_k =  x_hat(p-delta:p-delta+nc - 1 ,:);
            
           
            
            for k = 1:r
       
            dists(k) = distancess( x_tilde_j , x_hat_k(:,k));  
            end
            

            [~, id] = sort(dists);
            j_ = id(1);
%             disp(j_)
           
            e = 2;
            while ismember(j_,J) && e<=r
%                 disp('in')
                j_ = id(e);
                e = e+1;
            end
%             disp(j_)
            J = [J,j_];
%             disp(J)
     
            
            if p < N - W+ 1
                x_hat(p-1+nc:p-1+nc+delta-1, j_) = x_tilde(nc:nc+delta-1,j);

              
            else
                
                x_hat( p-1+nc: p-1+W, j_) = x_tilde(nc:W,j);
%                 plot(x_tilde(nc:W,j),'--')
%                 hold on
%                 plot(x_hat_k)
%                 plot(x_hat_k(:,j_),'b--o')
%                 pause(3)
%                 close all
                
            end
            
        end
    end
        
modes = x_hat;
end
                    
        
    
    
    
    

