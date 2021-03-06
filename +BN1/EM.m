function [ theta ] = EM( evidences, target, cpt, countfxn, domain,  pd_domain)
% EM - Expectation Maximization algorithm
% inputs:
% evidences - n by m vector where each of the m columns is one of the
% variables that influences target. Rows must match rows in target
% target - linear vector we desire to learn the distribution for.
% cpt - initial conditional probability table
% countfxn - function that specifies how to count each combination
% domain - cell array ({}) of m vectors containing the posible values of 
%          each of the m evidence vectors
% target_domain - set containing the possible values for the target vector
% 
% Sampe usage:
% EM([2,1,2;5,5,3],[0,1,1],rand(4,4),@sum,{[1,2],[3,5]},[0,1])
    if nargin<5 %assume true/false
        pd_domain = [1 0];
    end
    if nargin<4 %assume High/Medium/Low
        domain = ['H' 'M' 'L'];
    end

    epsilon = 10e-5;
    while 1
        theta = em_step(evidences, target, cpt, countfxn, domain, pd_domain);
        distance = norm(theta - cpt);
        if distance < epsilon
            break
        end
        cpt = theta;
    end  
    error('don''t call this function it''s not finished!');
end

%% em_step - one iteration of em
function [theta] = em_step( x, Pd, cpt, countfxn, domain, pd_domain)
    
    [row, column] = size(cpt);
    theta = zeros(row, column);
    for k=1:row
        pd_is_k = (Pd == pd_domain(k));
        pd_count = sum(pd_is_k);
        for l=1:column
            expected_sum = countfxn(x == domain(l), pd_is_k, cpt(k, l),isnan(Pd), pd_is_k);
            theta(k, l) = expected_sum / pd_count;
        end
    end
end
