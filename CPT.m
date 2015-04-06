function [ cpt ] = CPT ( Pd , prev_Pd )
% BN1.CPT - construct CPT to predict Pd (at a time t) given the previous Pd
% (at time t-1)
%   learn CPT parameters using Maximum Likelihood estimator
%
% Input:
%   x - discrete random variable.
%   Pd - evidence variable 'drink'.
%
% Output:
%   cpt - conditional probability table of the random variable given the
%         evidence drink.
%        eg.
%            prev_Pd
%        Pd | 0 | 1 |
%         1 |   |   |
%         0 |   |   |
% Note:
%   The elements/rows of evidence must correspond to x's
%
    domain = [0 1]; % use integer representation instead of char
    cpt = zeros(2, length(domain));
    
    %               count(Pd = {1, 0} , prev_Pd = {1, 0})
    % likelihood = -----------------------------------
    %                   count(prev_Pd = {1, 0})    
    
    for i = 1:length(domain)
        d = domain(i);
        x_is_d_given_Pd = [Pd(Pd == d) prev_Pd(Pd == d)];
        cpt(:, i) = Pr(x_is_d_given_Pd, [d 1; d 0])';
    end
end
