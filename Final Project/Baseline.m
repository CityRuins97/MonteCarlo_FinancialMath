% Parameter definiation
r= 0.0025;
lambda = 0.25;
sigma = 0.9;
IA = 50;
IB = 100;
PA = 450;
PB = 1000;
N = 10^7;
X0 = 771;
f = zeros(N,1);
Z = normrnd(0,1,N,1);
U = unifrnd(0,1,N,1);
price_pv = 1;
% Inverse method for generate T
T = -log(U)/lambda;
% GBM for X(T)
XT = X0*exp((r-sigma^2/2)*T+sigma*sqrt(T).*Z);
% Define k and calculate f(k) for X(T) <32
k = find(XT<32);
f(k) = max(min(XT(k)*IB/(IA+IB),IB),XT(k)*IB/(0.95*PB));
% Define k and calculate f(k) for 32<= X(T) <1000
k = find(XT>=32 & XT<1000);
% Probability of IPO
P_IPO = 0.65*((log(XT(k))-log(32))/(log(1000)-log(32)));
f(k) = P_IPO.*XT(k)*IB/(0.95*PB) + (1-P_IPO).*max(min(XT(k)*IB/(IA+IB),IB),XT(k)*IB/(0.95*PB));
% Define k and calculate f(k) for 1000<= X(T) <100000
k = find(XT>=1000 & XT<100000);
% Probability of IPO
P_IPO = 0.65+0.2*((log(XT(k))-log(1000))/(log(100000)-log(1000)));
f(k) = P_IPO.*XT(k)*IB/(0.95*PB) + (1-P_IPO).*max(min(XT(k)*IB/(IA+IB),IB),XT(k)*IB/(0.95*PB));
% Define k and calculate f(k) for 100000<= X(T)
k = find(XT>=100000);
f(k) = XT(k)*IB/(0.95*PB);
f = f.*exp(-r*T);
% Fair value 
IB_fair = mean(f);
% Overvaluation of PV 
dv = 100*(1000-771)/771;
% Fair price of common price 
Commonshare_fair = X0/(0.95*PB/price_pv);
% Overvaluation of common price in PV 
dc = 100*(1-Commonshare_fair)/Commonshare_fair;
% Summary 
[IB_fair dv Commonshare_fair dc]