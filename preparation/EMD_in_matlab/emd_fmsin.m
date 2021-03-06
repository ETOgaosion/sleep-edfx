% EMD_FMSIN.M
%
% P. Flandrin, Mar. 13, 2003
%
% computes and displays EMD for the sum of 2 sinusoidal 
% FM's + 1 Gaussian logon 
%
% displays reassigned spectrograms of the sum signal and of 
% the 3 first modes extracted
%
% produces Figure 1 in
%
% G. Rilling, P. Flandrin and P. Gon?alv?s
% "On Empirical Mode Decomposition and its algorithms"
% IEEE-EURASIP Workshop on Nonlinear Signal and Image Processing
% NSIP-03, Grado (I), June 2003


N = 2000;% # of data samples
T = 1:4:N;
t = 1:N;

p = N/2;% period of the 2 sinusoidal FM's

% sinusoidal FM 1
fmin1 = 1/64;% min frequency
fmax1 = 1.5*1/8;% max frequency
x1 = fmsin(N,fmin1,fmax1,p,N/2,fmax1);

% sinusoidal FM 1
fmin2 = 1/32;% min frequency
fmax2 = 1.5*1/4;% max frequency
x2 = fmsin(N,fmin2,fmax2,p,N/2,fmax2);

% logon
f0 = 1.5*1/16;% center frequency
x3 = amgauss(N,N/2,N/8).*fmconst(N,f0);

a1 = 1;
a2 = 1;
a3 = 1;

x = real(a1*x1+a2*x2+a3*x3);
x = x/max(abs(x));

[imf,ort,nbits] = emd(x,t);

emd_visu(x,t,imf,1);

figure(1)

% time-frequency distributions
Nf = 256;% # of frequency bins
Nh = 127;% short-time window length
w = window(Nh,'Kaiser');

[s,rs] = tfrrsp(x,T,Nf,w,1);
[s,rs1] = tfrrsp(imf(1,:)',T,Nf,w,1);
[s,rs2] = tfrrsp(imf(2,:)',T,Nf,w,1);
[s,rs3] = tfrrsp(imf(3,:)',T,Nf,w,1);

figure(4)

subplot(221)
imagesc(flipud(rs(1:128,:)))
set(gca,'YTick',[]);set(gca,'XTick',[])
xlabel('time')
ylabel('frequency')
title('signal')

subplot(222)
imagesc(flipud(rs1(1:128,:)))
set(gca,'YTick',[]);set(gca,'XTick',[])
xlabel('time')
ylabel('frequency')
title('mode #1')

subplot(223)
imagesc(flipud(rs2(1:128,:)))
set(gca,'YTick',[]);set(gca,'XTick',[])
xlabel('time')
ylabel('frequency')
title('mode #2')

subplot(224)
imagesc(flipud(rs3(1:128,:)))
set(gca,'YTick',[]);set(gca,'XTick',[])
xlabel('time')
ylabel('frequency')
title('mode #3')

%colormap(flipud(gray))
colormap(jet)
