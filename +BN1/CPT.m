function [ cpt ] = CPT ( x , Pd )
% BN1.CPT - construct CPT for a random variable in BN 1
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
%                Xb
%        Pd | H | M | L |
%         1 |   |   |   |
%         0 |   |   |   |
% Note:
%   The elements/rows of evidence must correspond to x's
%
    domain = ['H'+0 'M'+0 'L'+0]; % use integer representation instead of char
    cpt = zeros(2, length(domain));
    
    %               count(x = {H, M, L} , pd = {1, 0})
    % likelihood = -----------------------------------
    %                      count(pd = {1, 0})    
    
    for i = 1:length(domain)
        d = domain(i);
        x_is_d_given_Pd = [x(x == d) Pd(x == d)];
        cpt(:, i) = Pr(x_is_d_given_Pd, [d 1; d 0])';
    end
end
