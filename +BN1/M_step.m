%% M-step of the EM Algorithm

% parameter k of laplacian smoothing
k = get_laplace_k;

P_Pd = (Pd_count + k) / (row + k*2);
P_Pd_prime_given_Pd = (Pd_prime_given_Pd_count + k) / (row + k*2);
P_Xb_prime_given_Pd_prime = (Xb_prime_given_Pd_prime_count + k) / (row + k*3);
P_Xh_prime_given_Pd_prime = (Xh_prime_given_Pd_prime_count + k) / (row + k*3);
P_Xt_prime_given_Pd_prime = (Xt_prime_given_Pd_prime_count + k) / (row + k*3);