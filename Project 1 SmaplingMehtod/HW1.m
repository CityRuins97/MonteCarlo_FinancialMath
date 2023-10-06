clear, clc, close all
%%
% Q1
N = 100;
Ans = zeros(N,1);
for n = 1:N
    % rand returns a single uniformly distributed random number in the interval (0,1).
    i=rand;
    y = 2*(1-i);
    Ans(n) = y
end
%%
% Q2
N = 100;
Ans = zeros(N,1);
for n = 1:N
    i=rand;
    if i>0
        y=0.5*exp(i);
    else
        y=0.5*exp(-i);
    end
    Ans(n) = y
end

%%
% Q5 find the expectation and Variance
N = 10000;
raw_order = 1:100;
Ans = zeros(N,1);
for m = 1:N
    i = 0;
    random_order = raw_order(randperm(length(raw_order)));
    for n = 1:100
        if raw_order(1,n) == random_order(1,n)
            i = i + 1;
        end
    end
    Ans(m) = i;
end
Expection = mean(Ans)
Variance = var(Ans)

%%
% Q3-2
Ans = zeros(10000,2);
for i = 1:10000
    x = i/10000;
    y = (9*exp(-3))/(2*x*(1-x)^(3));
    if y >= 1
        Ans(i,1) = y;
        Ans(i,2) = x;
    end
end

a = min(Ans(:,1));

for i = 1:10000
    if Ans(i,1) == a
        lamda = Ans(i,2);
        disp(lamda)
    end
end

%%
% Q4
% a. Box-Muller
N = 10;
Ans_a = zeros(N,2);
for n = 1:N
    u1 = rand;
    u2 = rand;
    x = sqrt((-2)*log(u1))*cos(2*pi*u2);
    y = sqrt((-2)*log(u1))*sin(2*pi*u2);
    Ans_a(n,1) = x;
    Ans_a(n,2) = y;
end
disp(Ans_a);
%%
% b. Marsaglia-Bray
N = 10;
Ans_b = zeros(N,2);
for n = 1:N
    v1 = 2*rand-1;
    v2 = 2*rand-1;
    s = v1^2 + v2^2;
    if s <= 1
        x = v1*sqrt((-2)*log(s)/s);
        y = v2*sqrt((-2)*log(s)/s);
        Ans_b(n,1) = x;
        Ans_b(n,2) = y;
    end
end
disp(Ans_b);
%%
% c. rational approximation (for inverse of cdf)
% by Beasley-Springer-Moro algorithm
function x=InvNorm(u)
% Beasley-Springer-Moro algorithm for approximating the inverse normal.
% Input: u, a sacalar or matrix with elements between 0 and 1
% Output: x, an approximation for the inverse normal at u
%
% Reference:
% Pau Glasserman, Monte Carlo methods in financial engineering, 
% vol. 53 of Applications of Mathematics (New York), 
% Springer-Verlag, new York, 2004, p.67-68
%
% Example:
% a=0.1:0.1:0.9;
% b=InvNorm(a);
narginchk(1,1)     % Allow 1 input
nargoutchk(0,1)   % Allow 0 to 1 output
a0=2.50662823884;
a1=-18.61500062529;
a2=41.39119773534;
a3=-25.44106049637;
b0=-8.47351093090;
b1=23.08336743743;
b2=-21.06224101826;
b3=3.13082909833;
c0=0.3374754822726147;
c1=0.9761690190917186;
c2=0.1607979714918209;
c3=0.0276438810333863;
c4=0.0038405729373609;
c5=0.0003951896511919;
c6=0.0000321767881768;
c7=0.0000002888167364;
c8=0.0000003960315187;
y=u-0.5;
index1=abs(y)<0.42;
index2=not(index1);
x=zeros(size(u));
r1=abs(y(index1));
r=r1.^2;
x(index1)=r1.*polyval([a3,a2,a1,a0],r)./polyval([b3,b2,b1,b0,1],r);
r=u(index2);
r=min(r,1-r);
r=log(-log(r));
x(index2)=polyval([c8,c7,c6,c5,c4,c3,c2,c1,c0],r);
x=x.*sign(y);
end

