function [ theta ] = EM( x, y, Pd, cpt, x_domain, y_domain, pd_domain  )
% EM - Expectation Maximization algorithm for a variable depending on
%      two other variables.
% inputs
    if nargin<7 %assume Xa
        pd_domain = [1 2 3];
    end
    if nargin<6 %assume Xb/Xh/Xt
        y_domain = ['H' 'M' 'L'];
    end
    if nargin<5 %assume Xb/Xh/Xt
        x_domain = ['H' 'M' 'L'];
    end

    epsilon = 10e-5;
    while 1
        theta = em_step(x, y, Pd, cpt, x_domain, y_domain, pd_domain);
        distance = norm(theta - cpt);
        if distance < epsilon
            break
        end
        cpt = theta;
    end  
end

%% em_step - one iteration of em
function [theta] = em_step( x, y, Pd, cpt, x_domain, y_domain, pd_domain )
    [row, column, page] = size(cpt);
    theta = zeros(row, column, page);
    for k=1:page
        pd_is_k = (Pd == pd_domain(k));
        pd_is_nan = isnan(Pd);
        pd_count = sum(pd_is_k);
        for l=1:row
            for m=1:column
                missingValues = sum(x == x_domain(l) & isnan(y) & pd_is_k)...
                    + sum(isnan(x) & y == y_domain(m) & pd_is_k)...
                    + sum(isnan(x) & isnan(y) & pd_is_k)...
                    + sum(x == x_domain(l) & isnan(y) & pd_is_nan)...
                    + sum(isnan(x) & y == y_domain(m) & pd_is_nan)...
                    + sum(isnan(x) & isnan(y) & pd_is_nan)...
                    +sum(x == x_domain(l) & y == y_domain(m) & pd_is_nan);
                expected_sum = sum(x == x_domain(l) & y == y_domain(m) & pd_is_k) + cpt(l, m, k) * missingValues;
                theta(l, m, k) = expected_sum / pd_count;
            end
        end
    end
end
