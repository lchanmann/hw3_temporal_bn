function e = EM_Pd( pd_is_m, pd_prime_is_k, cpt, pd_is_nan )
%Computes the expectation as part of an EM step for Pd_prime
%given Pd.
%
% inputs:
% pd_is_m - vector of boolean values indicating the positions in the dataset
%          where the value of pd is as desired
% pd_prime_is_k - vector of boolean values indicating the positions in the
%                 dataset where the value of pd_prime is as desired
% cpt - probability known so far of pd_prime = k given pd = m (scalar)
% pd_is_nan - vector of boolean values indicating the positions in the
%             dataset where the value of pd is missing
e= sum(pd_is_m & pd_prime_is_k) + cpt * sum(pd_is_nan & pd_prime_is_k);
end

