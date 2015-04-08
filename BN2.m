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
%% Run EM algorithm and learn CPDs
P_Pd = Pr(Pd_train, [1 0]');
P_Xa = Pr(Xa_train, [1 2 3]');

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