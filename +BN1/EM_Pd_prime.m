function [ theta ] = EM_Pd_prime( Pd, Pd_prime, Xb, Xt, Xh, Xb_prime, Xt_prime, Xh_prime, cpt, domain,  pd_domain)
% EM - Expectation Maximization algorithm
    if nargin<5 %assume true/false
        pd_domain = [1 0];
    end
    if nargin<4 %assume High/Medium/Low
        domain = ['H' 'M' 'L'];
    end

    epsilon = 10e-5;
    while 1
        theta = em_step(Pd, Pd_prime, Xb, Xt, Xh, Xb_prime, Xt_prime, Xh_prime, cpt, domain, pd_domain);
        distance = norm(theta - cpt);
        if distance < epsilon
            break
        end
        cpt = theta;
    end  
end

%% em_step - one iteration of em
function [theta] = em_step( Pd, Pd_prime, Xb, Xt, Xh, Xb_prime, Xt_prime, Xh_prime, cpt, domain, pd_domain)
    
    [row, column] = size(cpt);
    theta = zeros(row, column);
    for k=1:row
        pd_is_k = (Pd_prime == pd_domain(k));
        pd_count = sum(pd_is_k);
        for l=1:column
            expected_sum = prob_pd_prime(Pd == domain(l), pd_is_k, cpt(k, l),isnan(Pd), pd_is_k);
            theta(k, l) = expected_sum / pd_count;
        end
    end
end
