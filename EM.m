function [ theta ] = EM( x, Pd, cpt )
% EM - Expectation Maximization algorithm

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

%     Pd_is_1 = (Pd == 1);
%     Pd_is_0 = (Pd == 0);
%     x_is_H = (x == 'H');
%     x_is_M = (x == 'M');
%     x_is_L = (x == 'L');
%     
%     theta = zeros(2, 3);
%     theta(1, 1) = sum(x_is_H & Pd_is_1) + cpt(1, 1) * sum(isnan(x) & Pd_is_1);
%     theta(1, 2) = sum(x_is_M & Pd_is_1) + cpt(1, 2) * sum(isnan(x) & Pd_is_1);
%     theta(1, 3) = sum(x_is_L & Pd_is_1) + cpt(1, 3) * sum(isnan(x) & Pd_is_1);
%     
%     theta(2, 1) = sum(x_is_H & Pd_is_0) + cpt(2, 1) * sum(isnan(x) & Pd_is_0);
%     theta(2, 1) = sum(x_is_H & Pd_is_0) + cpt(2, 1) * sum(isnan(x) & Pd_is_0);
%     theta(2, 1) = sum(x_is_H & Pd_is_0) + cpt(2, 1) * sum(isnan(x) & Pd_is_0);
end

