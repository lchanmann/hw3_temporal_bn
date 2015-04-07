% Bayesian Networks No.1
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #3              ');
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.1                ');
display('_______________________________________________________');
display(' ');

%% Run EM algorithm and learn CPDs
initialize_cpt = @() [theta_0('HML'); theta_0('HML')];

P_Pd = Pr(Pd_train, [1 0]');
P_Pd_prime_given_Pd = BN1.CPT(Pd_prime_train, Pd_train);
P_Xb_prime_given_Pd_prime = EM(Xb_prime_train, Pd_prime_train, initialize_cpt());
P_Xh_prime_given_Pd_prime = EM(Xh_prime_train, Pd_prime_train, initialize_cpt());
P_Xt_prime_given_Pd_prime = EM(Xt_prime_train, Pd_prime_train, initialize_cpt());

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Pd_prime_given_Pd);
display(P_Xb_prime_given_Pd_prime);
display(P_Xh_prime_given_Pd_prime);
display(P_Xt_prime_given_Pd_prime);

%% Confusion matrix (Train)
observation = [Pd_train Xb_prime_train Xh_prime_train Xt_prime_train];
Pd = Pd_train;
BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Train) ---------------------');
display(C);
display(accuracy);

%% Confusion matrix (Test)
observation = [Xb_test Xh_test Xt_test];
Pd = Pd_test;
BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Test) ---------------------');
display(C);
display(accuracy);

display('Press Enter to continue ... ');
pause;