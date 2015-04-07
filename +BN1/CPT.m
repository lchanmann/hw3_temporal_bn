function [ cpt ] = CPT ( Pd_prime , Pd )
% BN1.CPT - construct CPT of Pd_prime given Pd
%   learn CPT parameters using Maximum Likelihood estimator
%
% Input:
%   Pd_prime - Pd at time t+1.
%   Pd       - Pd at time t.
%
% Output:
%   cpt - conditional probability table of the Pd_prime given the Pd.
%        eg.
%            Pd_prime
%        Pd | 1 | 0 |
%         1 |   |   |
%         0 |   |   |
%
    domain = [1 0];
    cpt = zeros(2, length(domain));
    
    %               count(Pd_prime = {1, 0} , Pd = {1, 0})
    % likelihood = ----------------------------------------
    %                        count(Pd = {1, 0})    
    
    for i = 1:length(domain)
        v = domain(i);
        x_is_v_given_Pd = [Pd_prime(Pd_prime == v) Pd(Pd_prime == v)];
        cpt(i, :) = Pr(x_is_v_given_Pd, [v 1; v 0]);
    end
end
