% EMD_SAMPLING.M
%
% P. Flandrin, Mar. 13, 2003
%
% computes and plots an error measure in the EMD
% estimation of a single tone
%
% produces Figure 3 in
%
% G. Rilling, P. Flandrin and P. Gon?alv?s
% "On Empirical Mode Decomposition and its algorithms"
% IEEE-EURASIP Workshop on Nonlinear Signal and Image Processing
% NSIP-03, Grado (I), June 2003

N = 256;% # of data samples
t = 1:N;
tt = fix(N/4):fix(3*N/4);

Nf = 257;% # of tested fequencies
f = logspace(-log10(2*Nf),-log10(2),Nf);

x = cos(2*pi*f'*t);

se = zeros(1,Nf);

kmin = 65;

for k = kmin:Nf-1
	
	y = x(k,:);
		
	sy = sum((y(tt)).^2);
	
	imf = emd(y,t,[0.05,0.5,0.05]);
	se(k) = sqrt(sum((imf(1,tt)-y(tt)).^2)/sy);	

	[k size(imf)]
				
end

plot(log2(f(kmin:Nf-1)),max(log2(se(kmin:Nf-1)),-60),'o-')
axis([-8 -1 -16 0])
xlabel('log_{2}(frequency)')
ylabel('log_{2}(error)')
hold on
plot([-8 -1],[-14 0],'r')
grid
hold off
