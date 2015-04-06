function [theta] = EM_MLE( x, Pd, cpt )
%EM_MLE Performs MLE on the result of an EM
%   Detailed explanation goes here
    pd_domain = [1 0];
    domain = ['H' 'M' 'L'];
    
    [row, column] = size(cpt);
    theta = zeros(row, column);
    for k=1:row
        pd_is_k = (Pd == pd_domain(k));
        pd_count = sum(pd_is_k);
        for l=1:column
            expected_sum = sum(x == domain(l) & pd_is_k);
            theta(k, l) = expected_sum / pd_count;
        end
    end
end

