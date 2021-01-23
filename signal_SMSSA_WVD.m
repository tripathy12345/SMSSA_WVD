clc;
clear all;
close all;

%%%%if you want to use this code, please cite the following paper%%%
%%%%Panda, Rohan, et al. "Sliding Mode Singular Spectrum Analysis for the Elimination of Cross-Terms in Wigner–Ville Distribution."
%%Circuits, Systems, and Signal Processing (2020): 1-26.
%%Siddharth, T., Tripathy, R. K., & Pachori, R. B. (2019). Discrimination of focal and non-focal seizures from EEG signals using sliding mode singular spectrum analysis. IEEE Sensors Journal, 19(24), 12286-12296.
%%Harmouche, J., Fourer, D., Auger, F., Borgnat, P., & Flandrin, P. (2017). The sliding singular spectrum analysis: A data-driven nonstationary signal decomposition tool. IEEE Transactions on Signal Processing, 66(1), 251-263.
%%The ssa_decomp (autossa) function has been taken from the following
%%papers. Make sure, you should also cite the following two papers if you
%%use these codes
%%% Refs: 
% [J. Harmouche, D. Fourer, P. Flandrin, F. Auger and P. Borgnat. One
% or Two Components ? The Singular Spectrum Analysis answers. Proc. SLRA'2015. Grenoble, France.June 2015]
% [J. Harmouche, D. Fourer, P. Flandrin, F. Auger and P. Borgnat. Une ou deux composantes:
% la réponse de l'analyse spectrale singulière. Proc. GRETSI'15. Lyon, France]


%% Signal generation
n = 1:599;

x1 = 30 * cos( ((21*pi*n)/500 + 1072) .* (n/500) + 27*cos((pi*n)/300));
% x2 = 10 * cos( ((11*pi*n)/500 + 972) .* (n/500) + 17*cos((pi*n)/300));

 x2 = 42 * cos( (395 + 0.4 * n) .* ((2*pi*n)/5000) );

x_c = [x1', x2'];

x = x1 + x2;
plot(x)
% WVD of original signal
% subplot(152)
[wvd_original,f,t] = wvd(x, 100);
t=t*100;
 f=f*20;

subplot(211)
contour(t,f,wvd_original, 2);
title('Original WVD');

%% SM SSA
% y2 = slidingssa(x, 2, 39, 16, 1 ,0.1);
 y2 = slidingssa(x, 2, 47, 34, 1 ,0.1);
% WVD using SMSSA
wvd_smssa = wvd(y2(:,1)) + wvd(y2(:,2));
subplot(212)
contour(t,f,wvd_smssa, 2);
title('SMSSA based WVD');





