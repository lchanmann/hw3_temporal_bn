%% E-step of the EM Algorithm
model = BN1.model( P_Pd, P_Pd_prime_given_Pd, ...
    P_Xb_prime_given_Pd_prime, P_Xh_prime_given_Pd_prime, P_Xt_prime_given_Pd_prime);

Pd_count = [0 0];
Pd_prime_given_Pd_count = zeros(2,2);
Xb_prime_given_Pd_prime_count = zeros(2, 3);
Xh_prime_given_Pd_prime_count = zeros(2, 3);
Xt_prime_given_Pd_prime_count = zeros(2, 3);

for i=1:row
    Pd_count = Pd_count + model.pd_count(Pd_train(i));
    Pd_prime_given_Pd_count = Pd_prime_given_Pd_count + model.pd_prime_given_pd_count([Pd_prime_train(i) Pd_train(i)]);
    Xb_prime_given_Pd_prime_count = ...
        Xb_prime_given_Pd_prime_count + model.xb_given_pd_count([Xb_prime_train(i) Pd_prime_train(i)]);
    Xh_prime_given_Pd_prime_count = ...
        Xh_prime_given_Pd_prime_count + model.xh_given_pd_count([Xh_prime_train(i) Pd_prime_train(i)]);
    Xt_prime_given_Pd_prime_count = ...
        Xt_prime_given_Pd_prime_count + model.xt_given_pd_count([Xt_prime_train(i) Pd_prime_train(i)]);
end