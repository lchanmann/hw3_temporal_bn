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
domain = ['H' 'M' 'L'];
P_Pd = Pr(Pd_train, [1 0]');
P_Pd_prime_given_Pd = CPT(Pd_prime_train, Pd_train);
P_Pd_prime = BN1.CPT(Pd_train(1:length(Pd_train)-1), Pd_train(2:length(Pd_train)));
P_Xb_given_Pd_prime = EM_MLE(Xb_train, Pd_train, EM(Xb_train, Pd_train, [theta_0(domain); theta_0(domain)]));
P_Xh_given_Pd_prime = EM_MLE(Xb_train, Pd_train, EM(Xh_train, Pd_train, [theta_0(domain); theta_0(domain)]));
P_Xt_given_Pd_prime = EM_MLE(Xb_train, Pd_train, EM(Xt_train, Pd_train, [theta_0(domain); theta_0(domain)]));

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Pd_prime);
display(P_Xb_given_Pd_prime);
display(P_Xh_given_Pd_prime);
display(P_Xt_given_Pd_prime);

%% Confusion matrix (Train)
observation = [Xb_train Xh_train Xt_train];
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