r = 0.05;
S(1) = 100;
K = 110;
T = 1;
N = 10^5;
h = T/N;
Q = 10^2;
P = zeros(Q,1);
J = zeros(Q,1);
for c = 1:Q
   for i = 1:N
    X = normrnd(0,1);
    sig = 0.5*exp(-h)*(100/S(i));
    S(i+1) = S(i)+r*S(i)*h+sig*S(i)*sqrt(h)*X;
   end
M(c) = S(i+1);
P(c) = M(c);
J(c) = exp(-r*T)*max(P(c)-K,0);
end
V = mean(J);

i = 0:N;
t = i*h;
Y = S(i+1);
plot(t,Y);

