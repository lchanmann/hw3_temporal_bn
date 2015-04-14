%% E-step of the EM Algorithm
model = BN1.model( P_Pd, P_Pd_prime_given_Pd, ...
    P_Xb_prime_given_Pd_prime, P_Xh_prime_given_Pd_prime, P_Xt_prime_given_Pd_prime);

Pd = [0 0];
Pd_prime_given_Pd = zeros(2,2);
Xb_given_Pd = zeros(2, 3);
Xh_given_Pd = zeros(2, 3);
Xt_given_Pd = zeros(2, 3);

for i=1:row
    sample = [Xb_train(i) Xh_train(i) Xt_train(i) Pd_train(i) ...
        Pd_prime_train(i) Xb_prime_train(i) Xh_prime_train(i) Xt_prime_train(i)];
    
    Pd = Pd + model.pd_count(Pd_train(i));
    Pd_prime_given_Pd = Pd_prime_given_Pd + ...
        model.pd_prime_given_pd_count([Pd_prime_train(i) Pd_train(i)]);
    Xb_given_Pd = Xb_given_Pd + ...
        model.xb_given_pd_count([Xb_train(i) Pd_train(i)]);
    Xh_given_Pd = Xh_given_Pd + ...
        model.xh_given_pd_count([Xh_train(i) Pd_train(i)]);
    Xt_given_Pd = Xt_given_Pd + ...
        model.xt_given_pd_count([Xt_train(i) Pd_train(i)]);
end