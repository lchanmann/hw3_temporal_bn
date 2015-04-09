% Bayesian Networks No.2
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #3              ');
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.2                ');
display('_______________________________________________________');
display(' ');
%% Fill in the best value and learn CPDs
no_missing_Pd = fill_best( Pd_train );
no_missing_Xa = fill_best( Xa_train );
no_missing_Xb = fill_best_xi( Xb_train, no_missing_Pd, no_missing_Xa );
no_missing_Xh = fill_best_xi( Xh_train, no_missing_Pd, no_missing_Xa );
no_missing_Xt = fill_best_xi( Xt_train, no_missing_Pd, no_missing_Xa );

P_Pd = Pr(no_missing_Pd, [1 0]');
P_Xa = Pr(no_missing_Xa, [1 2 3]');
P_Xa_given_Pd_and_Xa = BN2.CPT(no_missing_Xb, no_missing_Pd, no_missing_Xa);

% P_Pd_prime = BN2.CPT(Pd_train(1:length(Pd_train)-1), Pd_train(2:length(Pd_train)), Xa_prime_train);
P_Pd_prime_given_Pd = BN1.CPT(Pd_prime_train, Pd_train);
% P_Xa_prime_given_Xa_and_Pd = BN2.CPT(Xa_prime_train, Pd_train, Xa_train);
% P_Xb_prime_given_Pd_prime = EM(Xb_prime_train, Pd_prime_train, initialize_cpt());
% P_Xh_prime_given_Pd_prime = EM(Xh_prime_train, Pd_prime_train, initialize_cpt());
% P_Xt_prime_given_Pd_prime = EM(Xt_prime_train, Pd_prime_train, initialize_cpt());

%% Confusion matrix (Train)
observation = [Pd_train Xa_train Xb_prime_train Xa_prime_train Xh_prime_train Xt_prime_train];
Pd = Pd_train;
BN2.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Train) ---------------------');
display(C);
display(accuracy);