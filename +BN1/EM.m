function [ theta ] = EM( x, Pd, cpt )
% EM - Expectation Maximization algorithm

    epsilon = 10e-5;
    while 1
        theta = em_step(x, Pd, cpt);
        distance = norm(theta - cpt);
        if distance < epsilon
            break
        end
        cpt = theta;
    end  
end

%% em_step - one iteration of em
function [theta] = em_step( x, Pd, cpt )
    pd_domain = [1 0];
    domain = ['H' 'M' 'L'];
    
    [row, column] = size(cpt);
    theta = zeros(row, column);
    for k=1:row
        pd_is_k = (Pd == pd_domain(k));
        pd_count = sum(pd_is_k);
        for l=1:column
            expected_sum = sum(x == domain(l) & pd_is_k) + cpt(k, l) * sum(isnan(x) & pd_is_k);
            theta(k, l) = expected_sum / pd_count;
        end
    end
end
