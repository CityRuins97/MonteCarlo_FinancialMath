S(1) = 100;
M(1) = 100;
v(1) = 0.04;
r = 0.03;
k = 2;
te = 0.04;
Sigv = 0.5;
ro = -0.7;
T = 0.5;
K = 120;
m = 252;
N = 10^5;
h = T/m;
for c = 1:N
      for i = 1:m
      X1 = normrnd(0,1);
      X2 = ro*X1+sqrt(1-ro^2)*normrnd(0,1);
      v(i+1) = v(i)+k*(te-v(i))*h+Sigv*sqrt(v(i))*sqrt(h)*X1;
      S(i+1) = S(i)+r*S(i)*h+sqrt(v(i))*S(i)*sqrt(h)*X2;
      end
      
      for i = 1:3
      Candy = S((252/3)*i);
      end
      Mx = max(Candy);
      J(c) = exp((-r*T)*max(Mx-K,0));
end
V = mean(J);
disp(V);