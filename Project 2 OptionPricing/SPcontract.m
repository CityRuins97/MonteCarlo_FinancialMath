% Autocallable reverse convertible option contract pricing
% Define function with parameter N and C
[PY] = SPcontract(1000000,5.7)
function [PY] = SPcontract(N,C)
S(1) = 100;
r = 0.04;
Sig = 0.3;
K = 55;
T = 1;
m = 4;
h = T/m;
W = zeros(N,1);
%First loop for Monte Carlo Simulation
for o = 1:N
    % Option pricing through BS model
    for i = 1:m
        Z = normrnd(0,1);
        S(i+1) = S(i)+r*S(i)*h+Sig*S(i)*sqrt(h)*Z;
    end
    % Save option price S(i) to M(i)
    M = S(2:end);
    % Check if M(i) bigger than S(i) from 2 to m
    for i = 2:m
        if M(i)>=S(1)
            tow = i;
            %check tow
            if tow <4
                sum1 = 0;
                for l = 1:tow
                    sum1 = sum1+exp(-r*l*h)*C*h;
                end
                PYD = sum1+exp(-r*tow*h)*S(1);
            else 
                 sum2 = 0;
                 for l = 1:tow
                     sum2 = sum2+exp(-r*l*h)*C*h;
                 end
                 %check M(i)
                 if M(i)>K
                 sum2 = sum2+exp(-r*tow*h)*S(1);
                 else 
                 sum2 = sum2+exp(-r*tow*h)*M(i);
                 end
                 PYD = sum2;
            end
        else 
            % if i < 4 continue the loop, find if next M(i) bigger than S(i)
            if i<4
                continue
            % if i = 4, check if M(i) bigger than K
            else 
                if M(i)>K
                    sum3 = 0;
                    for u = 1:i
                        sum3 = sum3+exp(-r*u*h)*C*h;
                    end
                    sum3 = sum3+exp(-r*4*h)*S(1);
                else
                    sum3 = 0;
                    for u = 1:i
                        sum3 = sum3+exp(-r*u*h)*C*h;
                    end
                sum3 = sum3+exp(-r*4*h)*M(i);
                end
                PYD = sum3;
            end
        end           
                    
    end
W(o) = PYD;
end
PY = mean(W);
end
