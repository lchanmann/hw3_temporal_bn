function [ cpt ] = CPT ( Pd_prime , Pd, Xa )
% BN2.CPT - construct CPT for a random variable in BN 2
%   learn CPT parameters using Maximum Likelihood estimator
%
% Input:
%   Pd - discrete random variable that Pd_prime depends on. Domain = {0, 1}
%   Pd_prime - evidence variable 'drink'. Domain = {0, 1}
%   Xa - conditional variable 'Ambulation status'. Domain = {1 2 3}
%
% Output:
%   cpt - conditional probability table of the random variable given the
%         evidence drink and ambulation status.
%        eg.
%           
%                               Pd
%              |Stationary |   Slow    |   Fast    |
%              |  0  |  1  |  0  |  1  |  0  |  1  |
% Pd_prime = 0 |     |     |     |     |     |     |
% Pd_prime = 1 |     |     |     |     |     |     |
% 
% Note:
%   The elements/rows of evidences must correspond to x's
%
    domain = [0 1];
    xa_domain = [1 2 3];
    cpt = zeros(2, length(domain) * length(xa_domain));
    
    %               count(Pd_prime = {0,1} , pd = {0, 1}, xa = {1 2 3})
    % likelihood = --------------------------------------------------
    %                      count(pd = {0, 1}, xa = {1 2 3})
    for k = 1:length(xa_domain)
        Pd_is_0_and_xa = sum(Pd == 0 & Xa == xa_domain(k));
        Pd_is_1_and_xa = sum(Pd == 1 & Xa == xa_domain(k));
        
        for i = 1:length(domain)
            x_i = Pd(Pd_prime == domain(i) & Xa == xa_domain(k));
            col = i + (k-1) * length(domain);
            cpt(1, col) = sum(x_i == 0) / Pd_is_0_and_xa;
            cpt(2, col) = sum(x_i == 1) / Pd_is_1_and_xa;
        end
    end
    % normalize lack of data samples
    cpt(isnan(cpt)) = 0;
end
