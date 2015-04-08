function [ theta ] = EM( x, y, Pd, cpt )
% EM - Expectation Maximization algorithm for a variable depending on
%      two other variables.
% inputs

    epsilon = 10e-5;
    while 1
        theta = em_step(x, y, Pd, cpt);
        distance = norm(theta - cpt);
        if distance < epsilon
            break
        end
        cpt = theta;
    end  
end

%% em_step - one iteration of em
function [theta] = em_step( x, y, Pd, cpt )
 em
    pd_domain = [1 2 3];
    domain = ['H' 'M' 'L'];
    
    [row, column, page] = size(cpt);
    theta = zeros(row, column, page);
    for k=1:page
        pd_is_k = (Pd == pd_domain(k));
        pd_count = sum(pd_is_k);
        for l=1:row
            x_count = sum(pd_is_x);
            for m=1:column
                expected_sum = sum(x == domain(l) & y == domain(m) & pd_is_k) ...
                    + cpt(l, m, k) * sum(isnan(y) & pd_is_k);
                theta(l, m, k) = expected_sum / pd_count;
            end
        end
    end
end
