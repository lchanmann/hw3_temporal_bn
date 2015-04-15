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
no_missing_Pd_prime = no_missing_Pd(2:end);
no_missing_Xa_prime = no_missing_Xa(2:end);
no_missing_Pd = no_missing_Pd(1:end-1);
no_missing_Xa = no_missing_Xa(1:end-1);
no_missing_Xb = no_missing_Xb(1:end-1);
no_missing_Xh = no_missing_Xh(1:end-1);
no_missing_Xt = no_missing_Xt(1:end-1);

P_Pd = Pr(no_missing_Pd, [1 0]');
P_Xa = Pr(no_missing_Xa, [1 2 3]');
P_Xb_given_Pd_and_Xa = BN2.CPT(no_missing_Xb, no_missing_Pd, no_missing_Xa, 'HML');
P_Xh_given_Pd_and_Xa = BN2.CPT(no_missing_Xh, no_missing_Pd, no_missing_Xa, 'HML');
P_Xt_given_Pd_and_Xa = BN2.CPT(no_missing_Xt, no_missing_Pd, no_missing_Xa, 'HML');
P_Pd_prime_given_Pd_and_Xa = BN1.CPT(no_missing_Pd_prime, no_missing_Pd);
P_Xa_prime_given_Pd_and_Xa = BN2.CPT(no_missing_Xa_prime, no_missing_Pd, no_missing_Xa, 1:3);

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Xa);
display(P_Xb_given_Pd_and_Xa);
display(P_Xh_given_Pd_and_Xa);
display(P_Xt_given_Pd_and_Xa);
display(P_Pd_prime_given_Pd_and_Xa);
display(P_Xa_prime_given_Pd_and_Xa);

%% Confusion matrix (Train)
observation = [Pd_train Xa_train Xb_prime_train Xa_prime_train Xh_prime_train Xt_prime_train];
Pd = Pd_train;
BN2.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Train) ---------------------');
display(C);
display(accuracy);